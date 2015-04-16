class Api::V1::PeopleController < ApplicationController
   before_action :authenticate_with_token!, only: [:create, :update, :destroy]
    respond_to :json

  def show
    respond_with Person.find(params[:id])
  end
    def index
    respond_with Person.all  
  end
    def create
    person = Person.new(person_params)
    if person.save
      render json: person, status: 201, location: [:api, person]
    else
      render json: { errors: person.errors }, status: 422
    end
  end
  
  def update
    person = Person.find(params[:id])
    if person.update(person_params)
      render json: person, status: 200, location: [:api, person]
    else
      render json: { errors: person.errors }, status: 422
    end
  end

   def destroy
    person = Person.find(params[:id])
    person.destroy
    head 204
  end

  private

    def person_params
      params.require(:person).permit(:firstname, :lastname)
    end
end
