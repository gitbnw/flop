require 'httparty'
module Google
    API_KEY = ENV['GOOGLE_API_KEY']

    class PlacesAPI
        include HTTParty
        base_uri 'https://maps.googleapis.com/maps/api/place/'
        # debug_output $stdout
        
        # https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&radius=500&type=restaurant&name=cruise&key=YOUR_API_KEY
        def self.get_nearby_places
            get("/nearbysearch/json?location=#{@position}&radius=#{@radius}&rankyby=distance&key=#{@api_key}")
        end

        def self.check_nearby_places
            responseObj = {
                "geocodeObj" => @geocodeObj,
                "nearbyObj" => get_nearby_places
            }
            raise responseObj["nearbyObj"].inspect
            responseObj

        end

        def self.request_nearby_places(search_params, radius = 8046) # 5 miles
            @radius = radius
            @api_key = API_KEY        
            @geocodeObj = GeocodeAPI.geocode_request_by search_params
            @position = search_params[:position].empty? ? @geocodeObj["position"] : search_params["position"] 
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
        # debug_output $stdout
        
        def self.get_geocode_object
            get("/json?address=#{@address}&key=#{@api_key}")
        end
        
        def self.get_reverse_geocode_object
           get("/json?latlng=#{@position}&result_type=street_address&key=#{@api_key}")
        end

        def self.checked_reverse_request
            response = get_reverse_geocode_object
            response["status"] == "OK" ? response["results"] : raise
        end
        
        def self.checked_request
            response = get_geocode_object
            response["status"] == "OK" ? response["results"] : (raise response.inspect)
        end
        
        def self.parsed_address
            checked_reverse_request[0]["formatted_address"]
        end
        
         def self.parsed_response
            lat_str = checked_request[0]["geometry"]["location"]["lat"]
            long_str = checked_request[0]["geometry"]["location"]["lng"]
            parsed_position = "#{lat_str}" + ",#{long_str}"
            parsed_address = checked_request[0]["formatted_address"]
            formatted_response = {
                "position" => parsed_position,
                "address" => parsed_address 
            }            
            return formatted_response
         end       

        def self.request_address(position)
            @position = position
            @api_key = API_KEY
            parsed_address
        end
        
        
        def self.geocode_request_by search_params # if they come with position we shouldn't be here
            @api_key = API_KEY  
            @address = search_params[:address]
            parsed_response
        end

        

    end
    
    class DistanceMatrixAPI
    include HTTParty
    #https://maps.googleapis.com/maps/api/distancematrix/json?origins=Seattle&destinations=San+Francisco|Victoria+BC&mode=bicycling&language=fr-FR&key=YOUR_API_KEY
    base_uri 'https://maps.googleapis.com/maps/api/distancematrix'
    
        def self.get_distance_object
           #debug_output $stdout
           get("/json?origins=#{@origins}&destinations=place_id:#{@destinations_str}&key=#{@api_key}&units=imperial")
        end
        
        def self.checked_request
            response = get_distance_object
            response["status"] == "OK" ? response : (raise response.inspect)
        end
        
        def self.distance_construct
            Hash[@destinations.zip(@elements_array)]
        end        
        
        def self.parsed_distance
            @elements_array = checked_request["rows"][0]["elements"] # need to check each element
            distance_construct
        end
        
        def self.request_distance(origins, destinations_array)
            @origins = origins
            @destinations = destinations_array
            @destinations_str = destinations_array.join('|place_id:')
            @api_key = API_KEY
            parsed_distance
        end  
        
    end
    
end
