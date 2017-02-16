require 'rails_helper'
include SessionsHelper

RSpec.describe UsersController, type: :controller do
    let(:new_user_attributes) do
        {
            name: "BlocHead",
            email: "blochead@bloc.io",
            password: "blochead",
            password_confirmation: "blochead"
        }
    end
    

    let(:my_user) { create(:user, email: "blochead@bloc.io") }
    let(:my_topic) { create(:topic) }
    let(:my_post) { create(:post, topic: my_topic, user: my_user) } 
    

    describe "GET new" do
        it "returns http success" do
            get :new
            expect(response).to have_http_status(:success)
        end
        
        it "instantiates a new user" do
            get :new
            expect(assigns(:user)).to_not be_nil
        end
    end
    
    describe "POST create" do
        it "returns an http redirect" do
            post :create, user: new_user_attributes
            expect(response).to have_http_status(:redirect)
        end
        
        it "creates a new user" do
            expect{
                post :create, user: new_user_attributes
            }.to change(User, :count).by(1)
        end
        
        it "sets user name properly" do
            post :create, user: new_user_attributes
            expect(assigns(:user).name).to eq new_user_attributes[:name]
        end
        
        it "sets user email properly" do
            post :create, user: new_user_attributes
            expect(assigns(:user).email).to eq new_user_attributes[:email]
        end
        
        it "sets user password properly" do
            post :create, user: new_user_attributes
            expect(assigns(:user).password).to eq new_user_attributes[:password]
        end
        
        it "sets user password_confirmation properly" do
            post :create, user: new_user_attributes
            expect(assigns(:user).password_confirmation).to eq new_user_attributes[:password_confirmation]
        end
        
        it "logs the user in after sign up" do
            post :create, user: new_user_attributes
            expect(session[:user_id]).to eq assigns(:user).id
        end
    end
    
    describe "not signed in" do
     let(:factory_user) { create(:user) }
 
     before do
       post :create, user: new_user_attributes
     end
 
     it "returns http success" do
       get :show, {id: factory_user.id}
       expect(response).to have_http_status(:success)
     end
 
     it "renders the #show view" do
       get :show, {id: factory_user.id}
       expect(response).to render_template :show
     end
 
     it "assigns factory_user to @user" do
       get :show, {id: factory_user.id}
       expect(assigns(:user)).to eq(factory_user)
     end
   end
   

    context "signed in user" do   
        before do
        create_session(my_user)
        end
    
        describe "GET show" do
            include RSpecHtmlMatchers

         
            it "returns http success" do
                get :show, {id: my_user.id}
                expect(response).to have_http_status(:success)
            end
        
            it "renders the #show view" do
                get :show, {id: my_user.id}
                expect(response).to render_template :show
            end
 
            it "assigns my_user to @user" do
                get :show, {id: my_user.id}
                expect(assigns(:user)).to eq(my_user)
            end
        
            it "include a list of favorited posts" do
                # Manually creating data to test our relationships
                Favorite.create!(user: my_user, post: my_post)
                
                # Test behavior of controller
                get :show, {id: my_user.id}
                expect(assigns(:user).favorites).to eq(my_user.favorites)
            end
        
            it 'has the correct number of votes' do
                Favorite.create!(user: my_user, post: my_post)
                Vote.create!(value: 1, user: my_user, post: my_post)
                get :show, {id: my_user.id}
            
            # Why am I able to access assigns(:user).votes, but not assigns(:favorite_posts).votes?
                my_post_votes = my_post.votes
                #binding.pry
                expect(assigns(:favorite_posts)[0].votes).to eq(my_post_votes)
                
            end
        
            it 'has the correct comments' do
                Favorite.create!(user: my_user, post: my_post)
                Comment.create!(body: "A new comment for post", user: my_user, post: my_post)
                get :show, {id: my_user.id}
            
                # Why am I able to access assigns(:user).comments, but not assigns(:favorite_posts).comments?
                expect(assigns(:favorite_posts)[0].comments).to eq(my_post.comments)
            end
        
        
            #it 'has the proper Gravatar' do
            #    get :show, {id: my_user.id}
            #    expect(response.body).to have_tag("img[src!='http://gravatar.com/avatar/bb6d1172212c180cfbdb7039129d7b03.png?s=48']")
            #end
        end
    end    

end







