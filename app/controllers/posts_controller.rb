class PostsController < ApplicationController
  def index
    @posts = Post.all
    @posts.each_with_index { |value, index| value.title = "SPAM" if index+1 == 1 || (index+1)%5 == 0 }
  end

  def show
  end

  def new
  end

  def edit
  end
end
