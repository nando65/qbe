class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #before_filter :check_user_is_active, except: [:login_page]

  before_filter :require_login


private

  def require_login
    unless current_user || controller_name == 'callbacks'
      #abort controller_name
      redirect_to controller: :login, action: :login_page
    end
  end

  # def check_user_is_active
  #    if current_user.nil?
  #      redirect_to controller: :login, action: :login_page
  #    end

  #  end


end
