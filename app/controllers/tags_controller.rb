class TagsController < ApplicationController

  def create
    @event = Event.find(params[:event_id])
    @tag = Tag.find_or_create_by(tag_params)
    existing_tagging = Tagging.find_by(event: @event, user:current_user.id, tag:@tag)
    unless existing_tagging
      Tagging.create(event: @event, user:current_user, tag:@tag)
    end
    # tag = tag_params
    # tag[:user] => current_user
    # @tag = Tag.create(tag)
    # @event.tags << @tag
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
