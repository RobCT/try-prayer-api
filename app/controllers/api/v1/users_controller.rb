class Api::V1::UsersController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  before_action :authenticate_with_token!, only: [:index, :show, :update, :destroy]
  respond_to  :json
  def index 
    respond_with User.all
  end
  def show
    respond_with User.find(params[:id])
  end
  


  def update
    user = current_user

    if user.update(user_params)
      render json: user, status: 202, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

def destroy
    user = User.find(params[:id])
    
    user.destroy
    head 204
end

  private

    def user_params
      params.require(:user).permit(:email, :password, :username, :firstname, :lastname, :password_confirmation)
    end
end