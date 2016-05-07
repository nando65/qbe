class ProfileController < ApplicationController

  def index
    if params[:subject]
    @user = User.find_by(id: params[:subject])
    @advices = User.find_by(id: params[:subject]).advises.order('created_at DESC')
    @endorse_filter=Endorse.where(follower_id=current_user.id && subject_id=params[:subject])
    array=[]
    @endorse_filter.each do |e|
      array<< e.endorsement_id
    end
    @endorsements = Endorsement.where.not(id: array)
    else
    @user = current_user
    @advices = current_user.advises_display(0,10)
    @endorsements = Endorsement.all
    end
    @advise = Advise.new
    @endorse = Endorse.new

  end

  def edit_user
    @user = User.find_by(id: current_user.id)
    @problem = Problem.new
  end

  def update
    @user = User.find_by(id: current_user.id)
    if @user.update user_params
      redirect_to action: :edit_user
    else
      render :edit_user
    end
  end

  def update_private_advise
    @user = User.find_by(id: current_user.id)
    if @user.update user_params_advise
      redirect_to action: :index
    else
      render :edit_user
    end
  end

  def create_follow_request
    User.create_follow_notification(params[:subject], params[:follower])
    redirect_to :controller => 'home', :action => 'index'
  end

  def destroy_follow
    Follow.destroy_all(subject_id: params[:subject], follower_id: params[:follower])
    redirect_to controller: :home, action: :index
  end


  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :company_name, :job_title, :private_advise)
  end

  def user_params_advise
    params.permit(:private_advise)
  end

  def advise_params
    params.require(:advise).permit(:gives_advice_to, :receives_advice_from, :advise)
  end



end