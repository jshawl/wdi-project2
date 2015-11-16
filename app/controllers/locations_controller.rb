class LocationsController < ApplicationController

  def create
    @location = Location.create(location_params)
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
