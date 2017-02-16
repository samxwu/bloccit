class UsersController < ApplicationController
    def new
        @user = User.new
        @posts = @user.posts.visible_to(current_user)
    end
    
    def show
        @user = User.find(params[:id])
        @favorite_posts = Post.joins(:favorites).where('favorites.user_id' => @user.id)
        
    end
    
    def create
        @user = User.new
        @user.name = params[:user][:name]
        @user.email = params[:user][:email]
        @user.password = params[:user][:password]
        @user.password_confirmation = params[:user][:password_confirmation]
        
        if @user.save
            flash[:notice] = "Welcome to Bloccit #{@user.name}!"
            create_session(@user)
            redirect_to root_path
        else
            flash.now[:alert] = "There was an error creating your account. Please try again."
            render :new
        end
        
    end
    
    
    private
    
    def posts_comments?(user, comments_posts)
        if comments_posts.downcase == "posts"
            user.posts ? "Posts" : "#{user.name} has not submitted any posts yet."
        elsif comments_posts.downcase == "comments"
            user.comments ? "Comments" : "#{user.name} has not submitted any comments yet."
        end
    end
    
    
end
