class HomeController < ApplicationController

  def index

    @posts = current_user.feed(0,10)
    @comment = Comment.new
    @comments = Comment.all
  end

  def create_share
    Post.share_post(params[:post_id], params[:current_user_id])
    redirect_to :controller => 'home', :action => 'index'
  end

  def create_like
    Like.like(params[:post_id], params[:current_user_id])
    redirect_to :controller => 'home', :action => 'index'
  end

end
