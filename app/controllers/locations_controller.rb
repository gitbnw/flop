class LocationsController < ApplicationController
    
 def index
   @locations = Location.search(location_params)
   render json: {nearby_locations: @locations}
 end

private

   def location_params
     params.slice!(:position)
     params.permit(:position)
   end  
   
end
