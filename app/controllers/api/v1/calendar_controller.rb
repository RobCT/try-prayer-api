class Api::V1::CalendarController < ApplicationController
  
  def create
    render_calendar_to_json(calendar_params)
  end






  private
  #@calDate = Date.new(params[:year], params[:month], params[:day])
  
    def calendar_params
      params.require(:calendar).permit(:year, :month, :day, :type)
    end  
end
