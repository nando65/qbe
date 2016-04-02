class ProfileController < ApplicationController

  def index

    @notifications = Notification.find(1)
  end
end