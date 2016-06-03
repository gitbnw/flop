class LocationsController < ApplicationController

 def index
   @response_locations = Location.search(location_params)
   @locations = Location.apply_response(@response_locations)
   
   render json: {nearby_locations: @locations}
 end

private

   def location_params
     params.slice!(:position)
     params.permit(:position)
   end

end
