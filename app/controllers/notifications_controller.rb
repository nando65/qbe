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
end
