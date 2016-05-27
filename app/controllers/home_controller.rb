class HomeController < ApplicationController
    
    before_action :authenticate_user!
    
    def index
        @user = current_user
    end
    
    def address
        @address = User.find(params[:id]).reverse_geocode
    end
    
    private
    
    def user_params
      puts params
      params.slice!(@user[:id])
      puts params
      params.permit(:id)
    end 
    
end
