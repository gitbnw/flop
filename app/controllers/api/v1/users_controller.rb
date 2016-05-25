 class Api::V1::UsersController < Api::V1::BaseController
 before_action :set_user, only: [:update]
   
   def update
    respond_to do |format|
      if @user.update(user_params)
        sign_in(@user == current_user ? @user : current_user, :bypass => true)
        format.html { redirect_to @user, notice: 'Your profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
   end
   
  private
    def set_user
      @user = User.find(params[:id]) 
    end

    def user_params
      accessible = [ :name, :email, :position ] # extend with your own params
      accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
      params.require(:user).permit(accessible)
    end  
    
 end