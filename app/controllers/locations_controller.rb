class LocationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @locations = Location.where('name ilike ?',"%#{params[:q]}%")
    respond_to do |format|
      format.html
      format.json { render :json => @locations.map(&:attributes) }
    end
  end

  def create
    lat = (rand * (38.997235-38.840312) + 38.840312)
    lon = (rand * (77.1230767-76.9091637)-77.1230767)
    @location = Location.create(location_params.merge(latitude:lat,longitude:lon))
    redirect_to events_path
  end

  def new
    @location = Location.new
  end

  def destroy
    Location.find_by(params[:id]).destroy
    redirect_to events_path
  end

  private
  def location_params
    params.require(:location).permit(:name,:address)
  end

end
