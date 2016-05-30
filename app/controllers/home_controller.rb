class HomeController < ApplicationController

    before_action :authenticate_user!

    def index
        @user = current_user
    end

    def address
      @user = User.find(params[:id])
      @address = @user.reverse_geocode

        raise @address.inspect
    end

    private

    def user_params
      puts params
      params.slice!(@user[:id])
      puts params
      params.permit(:id)
    end

end
