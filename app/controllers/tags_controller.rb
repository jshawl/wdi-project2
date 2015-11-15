class TagsController < ApplicationController

  def create
    @event = Event.find(params[:event_id])
    @tag = Tag.create(tag_params)
    @event.tags << @tag
    redirect_to @event
  end

  def new
    @event = Event.find(params[:event_id])
    @tag = Tag.new
  end

  private
  def tag_params
    params.require(:tag).permit(:tag)
  end

end
