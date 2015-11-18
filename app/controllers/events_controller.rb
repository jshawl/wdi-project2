class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = Event.all.order(when: :desc)
    @locations = @events.map(&:location)
  end

  def create
    @event = Event.create(event_params.merge(owner:current_user))
    @event.users << current_user
    redirect_to events_path
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
    unless @event.owner == current_user
      redirect_to @event
    end
  end

  def show
    @event = Event.find(params[:id])
    session[:event_id] = params[:id]
    @attendees = @event.users.where.not(id:current_user.id)
    @breakdown = {
      :mf => @attendees.where(gender:'m',preference:'f').length,
      :fm => @attendees.where(gender:'f',preference:'m').length,
      :mm => @attendees.where(gender:'m',preference:'m').length,
      :ff => @attendees.where(gender:'f',preference:'f').length,
      :mb => @attendees.where(gender:'m',preference:'b').length,
      :fb => @attendees.where(gender:'f',preference:'b').length
    }
    uniq_tags = @event.tags.uniq{ |t| t }
    @tags = uniq_tags.map{|tg|{tag:tg,count:Tagging.where(event:@event,tag:tg).length}}
    @back = :back
    events = Event.all.where.not(id: params[:id]).order(when: :desc)
    @other_locations = events.map(&:location)
  end

  def update
    @event = Event.find(params[:id])
    unless @event.owner == current_user
      redirect_to @event
    end
    @event.update(event_params)
    redirect_to events_path
  end

  def destroy
    @event = Event.find(params[:id])
    unless @event.owner == current_user
      redirect_to @event
    end
    @event.destroy
    redirect_to events_path
  end

  def attend
    @event = Event.find(params[:id])
    @event.users << current_user
    redirect_to events_path
  end

  def bail
    @event = Event.find(params[:id])
    @attendance = Attendance.find_by(user:current_user,event:@event)
    @attendance.destroy
    redirect_to events_path
  end

  def upvote
    @event = Event.find(params[:id])
    @event.upvote_by current_user
    redirect_to :back
  end

  def downvote
    @event = Event.find(params[:id])
    @event.downvote_by current_user
    if @event.get_upvotes.size-@event.get_downvotes.size <= -10
      destroy_by_vote(@event)
    end
    redirect_to :back
  end

  def unvote
    @event = Event.find(params[:id])
    @event.unvote_by current_user
    redirect_to :back
  end

  private
  def event_params
    params.require(:event).permit(:title,:when,:location_id)
  end

  def destroy_by_vote(event)
    @event.destroy
  end

end
