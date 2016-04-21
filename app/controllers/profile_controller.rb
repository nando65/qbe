class ProfileController < ApplicationController

  def index
    @user = User.find_by(id: params[:subject])
    @advices = current_user.advises_display(0,10)
    @advise = Advise.new
  end

  def edit_user
    @user = User.find_by(id: current_user.id)
  end

  def update
    @user = User.find_by(id: current_user.id)
    if @user.update user_params
      redirect_to action: :edit_user
    else
      render :edit_user
    end
  end

  def create_follow

    Follow.follow(2, params[:follower])
    redirect_to :controller => 'home', :action => 'index'
  end

  def destroy_follow
    Follow.destroy_all(subject_id: params[:subject], follower_id: params[:follower])
    redirect_to controller: :home, action: :index
  end


  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :company_name, :job_title)
  end

  def advise_params
    params.require(:advise).permit(:gives_advice_to, :receives_advice_from, :advise)
  end



end