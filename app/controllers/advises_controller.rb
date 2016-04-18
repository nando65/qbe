class AdvisesController < ApplicationController

  def index
  end

  def create
    @advise = Advise.new(advise_params)
    if @advise.save
      redirect_to :controller => 'profile', :action => 'index'
    end

  end

  private

  def advise_params
    params.require(:advise).permit(:receives_advice_from, :gives_advice_to, :advise)
  end
end
