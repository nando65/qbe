class NotificationsController < ApplicationController

#layout 'qbe_frontend'
  def index
    page = params[:page]
    page = 1 if page.nil?
    @notifications = Notification.all.page(page).per(5)
  end
  def select_affinity
    @affinity = Affinity.all
  end
end
