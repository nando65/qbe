class SearchController < ApplicationController
  def index
    @last_users = User.last(20).reverse
  end
  def redirect
    redirect_to :controller => 'search', :action => 'index'

  end
end
