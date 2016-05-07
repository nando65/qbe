class SearchController < ApplicationController
  def index
    @users =  User.all
    @filtered_endorsements = Endorsement.all
  end

  def search_people
    if params[:query]
    @users = User.where(nil)
    @users = @users.first_or_last_name_starts_with(params[:query])
    elsif params[:subject]
    @users=User.all
    end
    render :partial => 'search_people'
  end

  def search_virtue
    @filtered_endorsements = Endorsement.where(nil)
    @filtered_endorsements = @filtered_endorsements.endorsement_name_starts_with(params[:query])
    render :partial => 'search_virtue'
  end

  def people_filtered
      @users = User.return_user_by_attribute(params[:endorsement_name])
      @attribute = params[:endorsement_name]
  end

end
