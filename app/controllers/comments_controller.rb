class CommentsController < ApplicationController

  def index
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      # respond_to do |format|
      # format.html {redirect_to :controller => 'home', :action => 'index'}
      # format.js
    #end
    render partial: '/comment/post_form', locals: {comment: Comment.new, t: @comment.post}
  else
    render text: ''
    end

  end

  def update
    @user = User.find_by(current_user.id)
    if @user.update user_params
      redirect_to action: :edit_user
    else
      render :edit_user
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :commentary)
  end

end
