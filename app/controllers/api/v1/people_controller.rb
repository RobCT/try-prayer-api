class Api::V1::PeopleController < ApplicationController
    respond_to :json

  def show
    respond_with Person.find(params[:id])
  end
end
