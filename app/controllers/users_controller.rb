class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all.where.not(id:current_user.id)
  end

  def show
    @user = User.find(params[:id])
    @followers = @user.followers
    @following = @user.following
    @events = @user.events
  end

  def follow
    @followed = User.find(params[:id])
    if @followed == current_user
      redirect_to event_path(session[:event_id])
    end
    existing_follow = Following.find_by(follower: current_user, followed:@followed)
    unless existing_follow
      Following.create(follower:current_user,followed:@followed)
    end
    redirect_to :back
  end

  def unfollow
    @followed = User.find(params[:id])
    Following.find_by(follower:current_user,followed:@followed).destroy
    redirect_to :back
  end

end
