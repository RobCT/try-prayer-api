class Api::V1::EventsController < ApplicationController
     before_action :authenticate_with_token!, only: [:create, :update, :destroy]
    respond_to :json

  def show
    respond_with Event.find(params[:id])
  end
    def index
    respond_with Event.search(params) 
  end
    def create
    event = Event.new(event_params)
    if event.save
      render json: event, status: 201, location: [:api, event]
    else
      render json: { errors: event.errors }, status: 422
    end
  end
    def calendar
    render_calendar_to_json(event_params)
  end

  
  def update
    event = Event.find(params[:id])
    if event.update(event_params)
      render json: event, status: 202, location: [:api, event]
    else
      render json: { errors: event.errors }, status: 422
    end
  end

   def destroy
    event = Event.find(params[:id])
    event.destroy
    head 204
  end

  private

    def event_params
      params.require(:events).permit(:title, :eventdate, :eventstart, :eventend, :created_by, :last_modified_by, :year, :month, :day, :type)
    end
end
