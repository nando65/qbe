class CommentsController < ApplicationController

  def index
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
       # respond_to do |format|
       # format.html {redirect_to :controller => 'home', :action => 'index'}
       # format.js
       #  end
    #render '/comments/create', locals: { t: @comment.post}
    render json:{ result: :success, data: render_to_string( partial: '/comments/comment', locals: {d: @comment} ) }
    else
    render json:{ result: :error, data: @comment.errors.full_messages.first }
    end

  end

  def update
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :commentary)
  end

end
