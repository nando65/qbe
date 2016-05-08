class SearchController < ApplicationController
  def index
    @users_following =  current_user.following
    @users_not_following = User.all.limit(50)
    @filtered_endorsements = Endorsement.all
  end

  def search_people
    if params[:query]
     @users_following = User.where(nil)
     @users_following = @users_following.first_or_last_name_starts_with(params[:query])
     @users_not_following= User.where(nil)
      @users_not_following = @users_not_following.first_or_last_name_starts_with(params[:query])
    elsif
    @users=current_user.following
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
