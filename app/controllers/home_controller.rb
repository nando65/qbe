class HomeController < ApplicationController

  def index
		#sign_in User.find 155
    @page = params[:page]
    @page = 1 if params[:page].nil?
    @post = Post.new
    if current_user.feed(0,10).count == 0
    	@last_users = User.first(20).reverse
    else
    	@posts = current_user.feed(@page,25).order('created_at DESC')
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

  def create_like_ajax
    Like.like(params[:post_id], params[:current_user_id])
    render partial: '/home/destroy_like', locals: { t: Post.find(params[:post_id]), new_class: ' like-link-new', destroy_action: 'destroy_like_ajax' }
  end

  def destroy_like
    Like.destroy_all(user_id: params[:current_user_id], post_id: params[:post_id])
    redirect_to controller: :home, action: :index
  end

  def destroy_like_ajax
    Like.destroy_all(user_id: params[:current_user_id], post_id: params[:post_id])
		render partial: '/home/create_like', locals: { t: Post.find(params[:post_id]), new_class: ' like-link-new', create_action: 'create_like_ajax' }
  end


  def create_like_comment
    Like.like_comment(params[:comment_id], params[:current_user_id])
    redirect_to :controller => 'home', :action => 'index'
  end

  def create_like_comment_ajax
    Like.like_comment(params[:comment_id], params[:current_user_id])
		render partial: '/home/destroy_like_comment', locals: { d: Comment.find(params[:comment_id]), new_like: ' like-link-new', destroy_action: 'destroy_like_comment_ajax' }
  end


  def destroy_like_comment
    Like.destroy_all(user_id: params[:current_user_id], comment_id: params[:comment_id])
    redirect_to controller: :home, action: :index
  end

  def destroy_like_comment_ajax
    Like.destroy_all(user_id: params[:current_user_id], comment_id: params[:comment_id])
		render partial: '/home/create_like_comment', locals: { d: Comment.find(params[:comment_id]), new_like: ' like-link-new', create_action: 'create_like_comment_ajax' }
  end



end
