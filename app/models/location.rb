class Location < ActiveRecord::Base # not a active record model - parse json in initialize, attribute accessor

  include Google

 def self.search(location_params)
   @locations = request_by(location_params)
 end

  def self.request_by(location_params)
    Google::PlacesAPI.request_nearby_places(location_params[:position])
  end

  def self.apply_response(response_locations)
    response_locations.each do |response_location|
      find_or_initialize
    end

  end

end
