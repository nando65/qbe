class HomeController < ApplicationController

  def index
    @page = params[:page]
    @page = 1 if params[:page].nil?
    if current_user.feed(0,10).count == 0
    @last_users = User.first(20).reverse
    else
    @posts = current_user.feed(@page,10).order('created_at DESC')
    end
    @comment = Comment.new
  end

  def create_share
    Post.share_post(params[:post_id], params[:current_user_id])
    redirect_to :controller => 'home', :action => 'index'
  end

  def create_like
    Like.like(params[:post_id], params[:current_user_id])
    redirect_to :controller => 'home', :action => 'index'
  end

  def destroy_like
    Like.destroy_all(user_id: params[:current_user_id], post_id: params[:post_id])
    redirect_to controller: :home, action: :index
  end

  def create_like_comment
    Like.like_comment(params[:comment_id], params[:current_user_id])
    redirect_to :controller => 'home', :action => 'index'
  end

  def destroy_like_comment
    Like.destroy_all(user_id: params[:current_user_id], comment_id: params[:comment_id])
    redirect_to controller: :home, action: :index
  end

end
