class PostsController < ApplicationController

  def index
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to :back
    end

      # redirect_to :controller => 'profile', :action => 'index'

  end

  private

  private

  def post_params
    params.require(:post).permit(:follower_id, :user_id, :title, :subtitle)
  end
end