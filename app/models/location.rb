class Location # < ActiveRecord::Base # not a active record model - parse json in initialize, attribute accessor
    include Google

    attr_accessor :name, :participant, :longitude, :latitude, :type, :place_id, :open_now, :icon

    def initialize response_location
      @name = response_location["name"]
      @particpant = [true, false].sample
      @place_id = response_location["place_id"]
      @
      raise self.inspect
    end

    def self.search(location_params)
        @locations = request_by(location_params)
    end

    def self.request_by(location_params)
        Google::PlacesAPI.request_nearby_places(location_params[:position])
    end

    def self.apply_response(response_locations)
        response_locations["results"].each do |response_location|
            Location.new(response_location)
        end
    end
end
