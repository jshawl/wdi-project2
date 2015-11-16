class UsersController < ApplicationController
#
#   def following
#     @user = User.find(params[:id])
#   end
#
#   def followers
#     @user =  User.find(params[:id])
#   end
#
  def follow
    @followed = User.find(params[:id])
    existing_follow = Following.find_by(follower: current_user, followed:@followed)
    unless existing_follow
      Following.create(follower:current_user,followed:@followed)
    end
    redirect_to event_path(session[:event_id])
  end

  def unfollow
    @followed = User.find(params[:id])
    Following.find_by(follower:current_user,followed:@followed).destroy
    redirect_to event_path(session[:event_id])
  end

end
