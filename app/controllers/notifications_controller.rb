class NotificationsController < ApplicationController

#layout 'qbe_frontend'
  def index
    page = params[:page]
    page = 1 if page.nil?
    @notifications = User.find_by(id: current_user.id).notifications_display
     @unread = current_user.notifications.where(unread: 1)
     @unread.each do |u|
       u.unread = 0
       u.save
    end
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
    if !Affinity.find_by(id: params[:affinity_id]).nil? && current_user.id == params[:subject_id].to_i && !Notification.find_by(id: params[:notification_id], follower_id: params[:follower_id], user_id: params[:subject_id].to_i).nil?
      Follow.follow(params[:subject_id], params[:follower_id], params[:affinity_id] )
       Notification.destroy_all(id: params[:notification_id])
      redirect_to :action => 'index'
    else
     redirect_to :action => 'select_affinity', :subject => params[:subject_id], :follower => params[:follower_id], :notification_id => params[:notification_id]
    end
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
