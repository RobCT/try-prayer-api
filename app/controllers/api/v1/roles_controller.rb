class Api::V1::RolesController < ApplicationController
   before_action :authenticate_with_token!, only: [:create, :update, :destroy]
    respond_to :json

  def show
    respond_with Role.find(params[:id])
  end
    def index
    respond_with Role.all.order(:description)  
  end
    def create
    role = Role.new(role_params)
    if role.save
      render json: role, status: 201, location: [:api, role]
    else
      render json: { errors: role.errors }, status: 422
    end
  end

  
  def update
    role = Role.find(params[:id])
    if role.update(role_params)
      render json: role, status: 202, location: [:api, role]
    else
      render json: { errors: role.errors }, status: 422
    end
  end

   def destroy
    role = Role.find(params[:id])
    role.destroy
    head 204
  end

  private

    def role_params
      params.require(:role).permit(:description, :person_ids => [])
    end
end
