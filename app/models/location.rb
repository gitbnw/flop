class Location < ActiveRecord::Base
    
  include Google
 
 def self.search(location_params)
   @locations = create_or_find_by(location_params)
 end

  def self.create_or_find_by(location_params)
    Google::PlacesAPI.request_nearby_places(location_params[:position])
  end
 
   
end
