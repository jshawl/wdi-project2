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
    Following.create(follower:current_user,followed:@followed)
    redirect_to event_path(session[:event_id])
  end

end
