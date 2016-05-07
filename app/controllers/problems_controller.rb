class ProblemsController < ApplicationController

  def index
  end

  def create
    @problem = Problem.new(problem_params)
    if @problem.save
    redirect_to :controller => "profile", :action => "edit_user"
    # render json:{ result: :success, data: render_to_string( partial: '/comments/comment', locals: {d: @comment, i: nil} ) }
    else
    render json:{ result: :error, data: @comment.errors.full_messages.first }
    end
  end

  def update
  end

  private

  def problem_params
    params.require(:problem).permit(:user_id, :problem)
  end

end