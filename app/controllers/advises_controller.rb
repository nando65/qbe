class AdvisesController < ApplicationController

  def index
  end

  def create
    @advise = Advise.new(advise_params)
    if @advise.save
      render json:{ result: :success, data: render_to_string( partial: '/advise/advise', locals: {t: @advise} ) }
    end
      # redirect_to :controller => 'profile', :action => 'index'

  end

  private

  def advise_params
    params.require(:advise).permit(:receives_advice_from, :gives_advice_to, :advise)
  end
end
