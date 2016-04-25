class NotificationsController < ApplicationController

#layout 'qbe_frontend'
  def index
    page = params[:page]
    page = 1 if page.nil?
    @notifications = User.find_by(id: 1).notifications_display(0,10)
  end
  def select_affinity
    @affinity = Affinity.all
  end

  def select_affinity
    Notification.destroy_all(id: params[:notification_id])
    @subject = params[:subject]
    @follower =User.find_by(id: params[:follower])
    @affinity = Affinity.all
  end

def create_follow
    Follow.follow(params[:subject_id], params[:follower_id])
    redirect_to :controller => 'home', :action => 'index'
  end

  def confirm_follow
    @follow = Follow.find_by(subject_id: params[:subject_id], follower_id: params[:follower_id])
    if @follow.update follow_params
      redirect_to action: :index
    else
      render :edit_user
    end
  end

  def destroy_follow
    Follow.destroy_all(subject_id: params[:subject_id], follower_id: params[:follower_id])
    Notification.destroy_all(id: params[:notification_id])
    redirect_to controller: :home, action: :index
  end

  private

  def follow_params
    params.permit(:affinity_id, :weight)
  end

end
