class MapController < ApplicationController
def index
    @users = current_user.following.where("active_location = 0")
        @hash = Gmaps4rails.build_markers(@users) do |user, marker|
          marker.lat user.latitude
          marker.lng user.longitude
          marker.infowindow user.first_name+" "+user.last_name
          marker.picture({
              "url" => user.profile_picture.url(:small),
              "width" => 36,
              "height" => 36
            })
        end
end

  def map
    @users1 = current_user.following.where("active_location = 1 and subject_id = 2")
        @hash = Gmaps4rails.build_markers(@users1) do |user, marker|
          marker.lat user.latitude
          marker.lng user.longitude
          marker.infowindow user.first_name+" "+user.last_name
          marker.picture({
              "url" => user.profile_picture.url(:small),
              "width" => 36,
              "height" => 36
            })
        end
    render :partial => 'map'
  end

def update
    @user = User.find_by(id: current_user.id)
    if @user.update user_params
      redirect_to action: :index
    else
      render :edit_user
    end
end

private

  def user_params
    params.permit(:active_location)
  end


end
