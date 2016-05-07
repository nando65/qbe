class CommentsController < ApplicationController

  def index
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
    render json:{ result: :success, data: render_to_string( partial: '/comments/comment', locals: {d: @comment, i: nil} ) }
    else
    render json:{ result: :error, data: @comment.errors.full_messages.first }
    end
  end

  def update
  end

  def get_next_three
    @post = Post.find params[:post_id]
    @comments = @post.comments.offset(params[:last_comment]).limit(3)
    s = ''
    i = params[:last_comment].to_i
    @comments.each do |c|
      s += render_to_string( partial: '/comments/comment', locals: {d: c, i: i, c: @post.comments.length} )
      i = i + 1
    end
    render json: {  html: s, new_last_comment: i  }
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :commentary)
  end

end
