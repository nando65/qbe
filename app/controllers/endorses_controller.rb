class EndorsesController < ApplicationController

  def index
  end

  def create
    @endorse = Endorse.new(endorse_params)
    if @endorse.save
       redirect_to :back
      # redirect_to :controller => 'profile', :action => 'index'
    # render json:{ result: :success, data: render_to_string( partial: '/endorse/endorse', locals: {d: @comment} ) }
    else
      redirect_to :back
    # render json:{ result: :error, data: @comment.errors.full_messages.first }
    end

  end

  def update
  end

  private

  def endorse_params
    params.require(:endorse).permit(:subject_id, :follower_id, :endorsement_id)
  end
end
