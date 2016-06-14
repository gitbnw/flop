class SearchController < ApplicationController

 def index
   @locations = Location.apply_distances(new_locations, distance_object)
   @geocode = request_locations["geocodeObj"]

   #render json: {nearby_locations: @locations}
   render "list"
 end

private

    def request_locations
        Location.request_by(search_params)
    end
    
    def new_locations
        Location.apply_response(request_locations["nearbyObj"])
    end
    
    def distance_object
        Location.request_distances_by(search_params, new_locations.map(&:place_id))
    end
        

    def search_params
     params.require(:search).permit(:position, :address)
    end

end
