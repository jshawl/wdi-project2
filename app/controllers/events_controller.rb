class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = Event.all.order(when: :desc)
    @locations = @events.map(&:location)
  end

  def create
    @event = Event.create(event_params)
    @event.users << current_user
    redirect_to events_path
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
  end

  def show
    @event = Event.find(params[:id])
    session[:event_id] = params[:id]
    @attendees = @event.users.where.not(id:current_user.id)
    uniq_tags = @event.tags.uniq{ |t| t }
    @tags = uniq_tags.map{|tg|{tag:tg,count:Tagging.where(event:@event,tag:tg).length}}
  end

  def update
    @event = Event.find(params[:id])
  end

  def destroy
    @event = Event.find(params[:id])
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

  private
  def event_params
    params.require(:event).permit(:title,:when,:location_id)
  end

end
