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


  #   @locations = Location.all
  #   @geojson = Array.new
  #
  #   @locations.each do |location|
  #   @geojson << {
  #     type: 'Feature',
  #     geometry: {
  #       type: 'Point',
  #       coordinates: [location.longitude, location.latitude]
  #     },
  #     properties: {
  #       name: location.name,
  #       address: location.address,
  #       :'marker-color' => '#00607d',
  #       :'marker-symbol' => 'circle',
  #       :'marker-size' => 'medium'
  #     }
  #   }
  #   end
  #
  # respond_to do |format|
  # format.html
  # format.json { render json: @geojson }  # respond with the created JSON object

  private
  def location_params
    params.require(:location).permit(:name,:address)
  end

end
