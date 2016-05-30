 class Api::V1::UsersController < Api::V1::BaseController
   before_action :set_user, only: [:update]


  # PATCH/PUT /users/:id.:format
  def update
    # authorize! :update, @user
    respond_to do |format|
      if @user.update(user_params)
        sign_in(@user == current_user ? @user : current_user, :bypass => true)
        # format.html { redirect_to @user, notice: 'Your profile was successfully updated.' }
        format.json { render json: @user }
        raise @user.inspect
      else
        # format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      puts params
      params.slice!(:user)
      puts params
      params.slice!(:position)
      puts params
      params.permit(:position)
    end

 end
