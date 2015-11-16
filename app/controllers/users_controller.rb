class TagsController < ApplicationController

  def following
    @user = User.params[:id]
  end

  def followers
    @user =  User.params[:id]
  end

  def follow

  end

  def unfollow

  end


end
