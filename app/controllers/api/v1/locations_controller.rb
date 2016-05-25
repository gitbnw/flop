 class Api::V1::LocationsController < Api::V1::BaseController
 
   def show
     location = Location.find(params[:id])
     render json: location, status: 200
   end
 
   def index
     locations = Location.all
     render json: locations, status: 200
   end
 end