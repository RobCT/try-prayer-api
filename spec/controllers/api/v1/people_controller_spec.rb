require 'spec_helper'

describe Api::V1::PeopleController do
  describe "GET #show" do
    before(:each) do
      @person = FactoryGirl.create :person
      get :show, id: @person.id
    end

    it "returns the information about a reporter on a hash" do
      person_response = json_response
      expect(person_response[:lastname]).to eql @person.lastname
    end

    it { should respond_with 200 }
  end
end
