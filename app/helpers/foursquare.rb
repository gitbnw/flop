require 'httparty'
module Foursquare
    CLIENT_ID = ENV['FOURSQUARE_CLIENT_ID']
    CLIENT_SECRET = ENV['FOURSQUARE_CLIENT_SECRET']
    
    class SearchAPI
    include HTTParty
    base_uri 'https://api.foursquare.com/v2/venues/search/'
    
        def self.get_nearby_places
            @categories = "4d4b7104d754a06370d81259,4d4b7105d754a06374d81259,4d4b7105d754a06376d81259,4d4b7105d754a06378d81259"   
            get("?ll=#{@position}&radius=#{@radius}&intent='browse'&categoryId=#{@categories}&client_id=#{@client_id}&client_secret=#{@client_secret}&v=20160615")
        end

        def self.check_nearby_places
            responseObj = {
                "geocodeObj" => @geocodeObj,
                "nearbyObj" => get_nearby_places
            }
            responseObj

        end

        def self.request_nearby_places(search_params, radius = 8046) # 5 miles
            @radius = radius
            @client_id = CLIENT_ID
            @client_secret = CLIENT_SECRET
            @geocodeObj = Google::GeocodeAPI.geocode_request_by search_params
            @position = search_params[:position].empty? ? @geocodeObj["position"] : search_params["position"] 
            check_nearby_places
        end
        
    end
end