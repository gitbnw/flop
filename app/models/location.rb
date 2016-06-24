class Location
    include Google

    attr_accessor :name, :longitude, :latitude, :type, :open_now, :icon, :distance, :street_address, :city_st_address

    def initialize response_location
      @name = response_location["name"]
      @type = response_location["categories"][0]["name"]
      @url = response_location["url"]
      @street_address = "#{response_location["location"]["address"]}"
      @city_st_address = "#{response_location["location"]["city"]}, #{response_location["location"]["state"]}"
      @longitude = response_location["location"]["lng"]
      @latitude = response_location["location"]["lat"]
      @distance = (response_location["location"]["distance"] * 0.00062137).round(2)
      if response_location["hasMenu"]
        @menu = response_location["menu"]["url"]
      end
      @icon = "#{response_location["categories"][0]["icon"]["prefix"]}bg_32#{response_location["categories"][0]["icon"]["suffix"]}"
    end

    def self.apply_response(response_locations)
      locations_array = []

      response_locations["response"]["venues"].each do |response_location|
          locations_array << Location.new(response_location)
      end
        return locations_array.sort_by { |loc| loc.distance }
    end
    
    def self.request_position_by address
      Google::GeocodeAPI.request_position(address)
    end    
  
    
    def self.request_by search_params
      Foursquare::SearchAPI.request_nearby_places(search_params)
    end
    
end
