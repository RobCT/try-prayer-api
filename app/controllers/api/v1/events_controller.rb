class Api::V1::EventsController < ApplicationController
     before_action :authenticate_with_token!, only: [:create, :update, :destroy, :volunteersheet]
    respond_to :json

  def show
    if params[:sheets] 
    combined  = Array.new
    event = Event.find(params[:id])
    combined << event.attributes.merge({"volunteersheets" =>  event.volunteersheets.order([:rowindex])})
    respond_with combined
    else
    respond_with Event.find(params[:id])
    end
  end
    def index
      #combined  = Array.new
      #events = Event.search(params) 
      #events.each do |event|
      #  combined << event << event.volunteersheets
      #end
      #respond_with combined
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
    render_calendar_to_json(calendar_params)
  end
  
  def volunteersheet
    event = Event.find(params[:id])
    volunteersheet = event.volunteersheets.build(volunteersheet_params)
    if volunteersheet.save
      render json: volunteersheet, status: 201, location: [:api, event]
    else
      render json: { errors: volunteersheet.errors }, status: 422
    end
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
      params.require(:event).permit(:title, :eventdate, :eventstart, :eventend, :created_by, :last_modified_by)
    end
    def volunteersheet_params
      params.require(:event).permit(:about, :rowindex, :role_id, :person_id, :event_id)
    end
    def calendar_params
       params.require(:event).permit( :year, :month, :day, :type)
     
    end
end
