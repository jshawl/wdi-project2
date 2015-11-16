class EventsController < ApplicationController
  before_action :authenticate_user!
#   events GET    /events(.:format)                              events#index
#          POST   /events(.:format)                              events#create
# new_event GET    /events/new(.:format)                          events#new
# edit_event GET    /events/:id/edit(.:format)                     events#edit
#    event GET    /events/:id(.:format)                          events#show
#          PATCH  /events/:id(.:format)                          events#update
#          PUT    /events/:id(.:format)                          events#update
#          DELETE /events/:id(.:format)                          events#destroy

  def index
    @events = Event.all
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
    @attendees = @event.users
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
