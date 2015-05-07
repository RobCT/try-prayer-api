class Api::V1::PrayersController < ApplicationController
     before_action :authenticate_with_token!, only: [:index, :show, :calendar, :create, :update, :destroy, :volunteersheet]
    respond_to :json

  def show
    respond_with Prayer.find(params[:id])
  end
    def index
      respond_with Prayer.search(params) 
  end
    def create
    prayer = Prayer.new(prayer_params)
    if prayer.save
      render json: prayer, status: 201, location: [:api, prayer]
    else
      render json: { errors: prayer.errors }, status: 422
    end
  end
    def calendar
    render_calendar_to_json(calendar_params)
  end
  

  
  def update
    prayer = Prayer.find(params[:id])
    if prayer.update(prayer_params)
      render json: prayer, status: 202, location: [:api, prayer]
    else
      render json: { errors: prayer.errors }, status: 422
    end
  end

   def destroy
    prayer = Prayer.find(params[:id])
    prayer.destroy
    head 204
  end

  private

    def prayer_params
      params.require(:prayer).permit(:title, :prayerdate, :prayer, :user_id)
    end
    def calendar_params
       params.require(:prayer).permit( :year, :month, :day, :type)
     
    end
end
