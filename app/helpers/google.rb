require 'httparty'
module Google
    API_KEY = ENV['GOOGLE_API_KEY']

    class PlacesAPI
        include HTTParty
        base_uri 'https://maps.googleapis.com/maps/api/place/'

        def get_nearby_places
            get("/nearbysearch/json?location=#{@position}&radius=#{@radius}&key=#{@api_key}")
        end

        def check_nearby_places
            response = get_nearby_places(@position, @radius, @api_key)
            response["position"].nil? ? raise : response
        end

        def self.request_nearby_places(position, radius)
            @position = position
            @radius = radius
            @api_key = API_KEY
            check_nearby_places
        end


        def self.get_place_details(placeid, api_key = API_KEY)
            response = get("/details/json?placeid=#{placeid}&key=#{api_key}")
            raise response.inspect
        end
    end

    class GeocodeAPI
        include HTTParty
        base_uri 'https://maps.googleapis.com/maps/api/geocode/'

        def self.get_geocode_object
           get("/json?latlng=#{@position}&result_type=street_address&key=#{@api_key}")
        end

        def self.checked_request
            response = get_geocode_object
            response["status"] == "OK" ? response["results"] : raise
        end

        def self.parsed_address
            checked_request[0]["formatted_address"]
        end

        def self.request_address(position)
            @position = position
            @api_key = API_KEY
            parsed_address
        end

    end
end
