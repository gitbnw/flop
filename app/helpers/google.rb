require 'httparty'
module Google
    API_KEY = ENV['GOOGLE_API_KEY']

    class PlacesAPI
        include HTTParty
        base_uri 'https://maps.googleapis.com/maps/api/place/'

        def self.get_nearby_places(position, radius, api_key = API_KEY)
            response = get("/nearbysearch/json?location=#{position}&radius=#{radius}&key=#{api_key}")
        end

        def self.get_place_details(placeid, api_key = API_KEY)
            get("/details/json?placeid=#{placeid}&key=#{api_key}")
        end
    end

    class GeocodeAPI
        include HTTParty
        base_uri 'https://maps.googleapis.com/maps/api/geocode/'

        def self.get_address(position, api_key = API_KEY)
          puts "position:" + " " + "#{position}"
          response = get("/json?latlng=#{position}&key=#{api_key}")
          raise response.inspect
        end

    end
end
