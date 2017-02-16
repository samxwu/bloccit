require 'rails_helper'
include SessionsHelper

RSpec.describe "users/show.html.erb", type: :view do
    let(:my_user) { create(:user, email: "blochead@bloc.io") }
    let(:my_topic) { create(:topic) }
    let(:my_post) { create(:post, topic: my_topic, user: my_user) } 
    
    
     context "signed in user" do   
        before do
        create_session(my_user)
        end
    
        describe "GET show" do
            include RSpecHtmlMatchers
            
            it 'has the proper Gravatar' do
                Favorite.create!(user: my_user, post: my_post)
                #View spec is not associated with controller. Have to assign the @user & @favorite_posts into users/show.html.erb template with method #assign
                assign(:user, my_user)
                assign(:favorite_posts, my_post)
               
                render
                expect(rendered).to have_tag("img[src!='http://gravatar.com/avatar/bb6d1172212c180cfbdb7039129d7b03.png?s=48']")
            end
        end
    end    
    
    
end
