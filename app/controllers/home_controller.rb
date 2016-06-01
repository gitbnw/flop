class HomeController < ApplicationController

    before_action :authenticate_user!

    def index
        @user = current_user
    end

    def address
      @user = User.find(params[:id])
      @formatted_address = @user.reverse_geocode_address
      raise
    end

    private

    def user_params
      puts params
      params.slice!(@user[:id])
      puts params
      params.permit(:id)
    end

end
