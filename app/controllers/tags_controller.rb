class TagsController < ApplicationController

  def create
    @event = Event.find(params[:event_id])
    @tag = Tag.find_or_create_by(tag_params)
    existing_tagging = Tagging.find_by(event: @event, user:current_user, tag:@tag)
    unless existing_tagging
      Tagging.create(event: @event, user:current_user, tag:@tag)
    end
    redirect_to @event
  end

  def new
    @event = Event.find(params[:event_id])
    @tag = Tag.new
  end

  def duplicate
    @event = Event.find(params[:event_id])
    @tag = Tag.find(params[:id])
    existing_tagging = Tagging.find_by(event: @event, user:current_user, tag:@tag)
    unless existing_tagging
      Tagging.create(event: @event, user:current_user, tag:@tag)
    end
    redirect_to @event
  end

  def untag
    @event = Event.find(params[:event_id])
    @tag = Tag.find(params[:id])
    @tagging = Tagging.find_by(user:current_user,event:@event,tag:@tag)
    @tagging.destroy
    redirect_to @event
  end

  private
  def tag_params
    params.require(:tag).permit(:tag)
  end

end
