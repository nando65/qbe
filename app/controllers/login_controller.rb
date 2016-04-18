class LoginController < ApplicationController

layout 'qbe_frontend', :only => [:login_page]
skip_before_filter :require_login

  def login_page
    redirect_to controller: :home, action: :index unless current_user.nil?
  end
end
