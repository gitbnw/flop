require 'httparty'
module Google
    API_KEY = ENV['GOOGLE_API_KEY']

    class PlacesAPI
        include HTTParty
        base_uri 'https://maps.googleapis.com'

        def self.get_nearby_places(lng, lat, radius, api_key = API_KEY)
            # https://maps.googleapis.com/maps/api/place/nearbysearch/output?parameters
            puts api_key
            get("/maps/api/place/nearbysearch/json?location=#{lng},#{lat}&radius=#{radius}&key=#{api_key}")
        end

        def self.get_place_details(placeid, api_key = API_KEY)
            get("/maps/api/place/details/json?placeid=#{placeid}&key=#{api_key}")
        end
    end
end
