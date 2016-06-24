class SearchController < ApplicationController

 def index
  @locations = new_locations
  @geocode = request_locations["geocodeObj"]
  @init_map_parameters = {
      "search_position": @geocode["position"],
      "locations_array": @locations
  }

    respond_to do |format|
      format.js { render "list" }
    end
    
    
    
 end

private

    def request_locations
        Location.request_by(search_params)
    end
    
    def new_locations
        Location.apply_response(request_locations["nearbyObj"])
    end

    def search_params
     params.require(:search).permit(:position, :address)
    end

end
