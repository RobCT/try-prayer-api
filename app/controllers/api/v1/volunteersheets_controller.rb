class Api::V1::VolunteersheetsController < ApplicationController
     before_action :authenticate_with_token!, only: [:create, :update, :destroy]
    respond_to :json

  def show
    respond_with Volunteersheet.find(params[:id])
  end
    def index
    respond_with Volunteersheet.all  
  end
    def create
    volunteersheet = Volunteersheet.new(volunteersheet_params)
    if volunteersheet.save
      render json: volunteersheet, status: 201, location: [:api, volunteersheet]
    else
      render json: { errors: volunteersheet.errors }, status: 422
    end
  end

  
  def update
    volunteersheet = Volunteersheet.find(params[:id])
    if volunteersheet.update(volunteersheet_params)
      render json: volunteersheet, status: 202, location: [:api, volunteersheet]
    else
      render json: { errors: volunteersheet.errors }, status: 422
    end
  end

   def destroy
    volunteersheet = Volunteersheet.find(params[:id])
    volunteersheet.destroy
    head 204
  end

  private

    def volunteersheet_params
      params.require(:volunteersheet).permit(:about, :rowindex, :role_id, :person_id, :event_id, :template_id)
    end
end
