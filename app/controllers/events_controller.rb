class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = Event.all.where("created_at >= ?",Time.now.beginning_of_day.in_time_zone("UTC")).where("created_at < ?", Time.now.in_time_zone("UTC")).order(when: :asc)
    # @events = Event.created_today
    ## so that there's something to prevent the map from erroring out
    if @events == [] # or .empty?
      @events = Event.all.order(when: :asc).last(2)
    end
    attendances = @events.map{|e| e.users.size}
    @max = attendances.max
    @locations = @events.map(&:location)
    today_taggings = Tagging.all.where("created_at >= ?",Time.now.beginning_of_day.in_time_zone("UTC"))
      .where("created_at < ?", Time.now.in_time_zone("UTC"))
    today_tags = today_taggings.uniq.pluck(:tag_id).compact
    # @recent_taggings = Tagging.recent
    @recent_taggings = today_tags.map{|tg|{tag:Tag.find(tg),count:today_taggings.where(tag:tg).length}}
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
      # maybe with a flash notice, too?
      redirect_to @event
    end
  end

  def show
    @event = Event.find(params[:id])
    session[:event_id] = params[:id]
    @attendees = @event.users
    uniq_tags = @event.tags.uniq{ |t| t }
    @tags = uniq_tags.map{|tg|{tag:tg,count:Tagging.where(event:@event,tag:tg).length}}
    # @tags = @event.uniq_tags
    @events = Event.all.where("created_at >= ?",Time.now.beginning_of_day.in_time_zone("UTC"))
      .where("created_at < ?", Time.now.in_time_zone("UTC"))
      .order(when: :desc)
    # if you create that model method, you can reuse here too
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
    existing_attendance = Attendance.find_by(event: @event, user:current_user)
    # maybe find_or_create_by...
    unless existing_attendance
      @event.users << current_user
    end
    redirect_to @event
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
      # you can do this automitically with a before_save on Event model
      # check out http://api.rubyonrails.org/classes/ActiveRecord/Callbacks.html
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
