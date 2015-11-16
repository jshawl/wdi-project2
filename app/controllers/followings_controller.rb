class FollowingsController < ApplicationController

  def create
    @user = current_user
    @friend = User.find(params[:id])
  end

  def destroy
    @user =  User.find(params[:id])
  end

end
