require 'httparty'
module Google

  class PlacesAPI
    include HTTParty
    base_uri "maps.googleapis.com/maps/api/place/"
    default_params :apiKey => ENV['GOOGLE_API_KEY']

    def self.get_nearby_places(lng, lat, radius, types, name)
      get("nearbysearch/json?location=#{lng},#{lat}&radius=#{radius}%types=#{types}&name=#{name}&key=#{:apiKey}")
    end

    def self.get_place_details(placeid)
      get("details/json?placeid=#{placeid}&key=#{:apiKey}")
    end

  end

end
