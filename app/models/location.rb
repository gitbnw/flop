class Location
    include Google

    attr_accessor :name, :participant, :longitude, :latitude, :types, :place_id, :open_now, :icon, :price_level, :rating, :icon, :distance

    def initialize response_location
      @name = response_location["name"]
      @particpant = [true, false].sample
      @place_id = response_location["place_id"]
      @types = response_location["types"]
      unless response_location["opening_hours"].nil? 
        @open_now = response_location["opening_hours"]["open_now"]
      end
      @price_level = response_location["price_level"]
      @rating = response_location["rating"]
      @icon = response_location["icon"]
      @icon = assign_assign(response_location["types"])
    end

    def self.search(location_params)
        @locations = request_by(location_params)
    end

    def self.request_by(location_params)
        Google::PlacesAPI.request_nearby_places(location_params[:position])
    end

    def self.apply_response(response_locations)
      locations_array = []
      response_locations["results"].each do |response_location|
        if (response_location["types"] & ["restaurant", "shop", "store", "food", "bar", "lodging"]).any?
          locations_array << Location.new(response_location)
        end
      end
        return locations_array
    end
    
    def self.request_distances_by location_params, destinations_array
      Google::DistanceMatrixAPI.request_distance(location_params[:address], destinations_array)
    end
    
    def self.request_position_by address
      Google::GeocodeAPI.request_position(address)
    end    
    
    def self.apply_distances locations_array, distance_object
      locations_array.each do |location|
        distance_object.select{|k, v| location.distance = v["distance"]["text"] if location.place_id == k}
      end
    end
    
    def self.request_by search_params
      Google::PlacesAPI.request_nearby_places(search_params)
      # Google::GeocodeAPI.request_by(location_params)
    end
    
end
