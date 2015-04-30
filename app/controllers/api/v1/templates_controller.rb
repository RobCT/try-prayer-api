class Api::V1::TemplatesController < ApplicationController
   before_action :authenticate_with_token!, only: [:create, :update, :destroy]
    respond_to :json


  
    def show
    if params[:sheets] 
    combined  = Array.new
    template = Template.find(params[:id])
    combined << template.attributes.merge({"volunteersheets" =>  template.volunteersheets.order([:rowindex])})
    respond_with combined
    else
    respond_with Template.find(params[:id])
    end
  end
  
    def index
    respond_with Template.all  
  end
    def create
    template = Template.new(template_params)
    if template.save
      render json: template, status: 201, location: [:api, template]
    else
      render json: { errors: template.errors }, status: 422
    end
  end
  
  def clone_to_event
    template = Template.find(params[:template_id])
    sheets = template.volunteersheets
    event_sheets = []
    sheets.each do |s|
      attribs = s.attributes
      attribs[:id] = nil
      attribs[:template_id] = nil
      attribs[:event_id] = params[:event_id]
      
      event_sheets << attribs

    end
    if eventsheets = Volunteersheet.create(event_sheets)
     
     render json: eventsheets, status: 201, location: [:api, template]
    else
     render json: {errors: eventsheet.errors}, status: 422
    end
    
  end

  def volunteersheet
    template = Template.find(params[:id])
    volunteersheet = template.volunteersheets.build(volunteersheet_params)
    if volunteersheet.save
      render json: volunteersheet, status: 201, location: [:api, template]
    else
      render json: { errors: volunteersheet.errors }, status: 422
    end
  end
  
  def update
    template = Template.find(params[:id])
    if template.update(template_params)
      render json: template, status: 202, location: [:api, template]
    else
      render json: { errors: template.errors }, status: 422
    end
  end

   def destroy
    template = Template.find(params[:id])
    template.destroy
    head 204
  end

  private
    def volunteersheet_params
      params.require(:template).permit(:about, :rowindex, :role_id, :person_id)
    end
    def template_params
      params.require(:template).permit(:title, :event_id, :template_id,:sheets )
    end
end
