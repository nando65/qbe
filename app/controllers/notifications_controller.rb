class NotificationsController < ApplicationController

#layout 'qbe_frontend'
  def index
    page = params[:page]
    page = 1 if page.nil?
    @notifications = User.find_by(id: current_user.id).notifications_display(0,10).order('created_at DESC')
  end
  # def select_affinity
  #   @affinity = Affinity.all
  # end
  def select_affinity
    @subject = params[:subject]
    @follower =User.find_by(id: params[:follower])
    @notification_id = params[:notification_id]
    @affinity = Affinity.all
  end
  def create_follow
    if !Affinity.find_by_id(params[:affinity_id]).nil? && current_user.id == params.subject_id.to_i && Notification.find_by(follower_id: current_user.id, user_id: t.id).nil?
      Follow.follow(params[:subject_id], params[:follower_id], params[:affinity_id] )
    end
      Notification.destroy_all(id: params[:notification_id])
      redirect_to :controller => 'home', :action => 'index'

  end
  def destroy_follow
    Follow.destroy_all(subject_id: params[:subject_id], follower_id: params[:follower_id])
    Notification.destroy_all(id: params[:notification_id])
    redirect_to controller: :home, action: :index
  end
  def destroy_follow_request
    Notification.destroy_all(id: params[:notification_id])
    redirect_to controller: :home, action: :index
  end

  private
  def follow_params
    params.permit(:affinity_id, :weight)
  end
end
