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
  end

  def create
    @event = Event.create(event_params)
    @event.location = Location.create(address:"jdfjskf",name:"the basement")
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

  private
  def event_params
    params.require(:event).permit(:title,:when)
  end

end
