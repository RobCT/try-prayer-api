require 'spec_helper'

describe Api::V1::EventsController do
  describe "GET #show" do
    before(:each) do
      
      @event = FactoryGirl.create :event
      get :show, id: @event.id
    end

    it "returns the information about a reporter on a hash" do
      event_response = json_response
      expect(event_response[:title]).to eql @event.title
    end
    


    it { should respond_with 200 }
  end
    describe "GET #index" do
    before(:each) do
      4.times { FactoryGirl.create :event }
      get :index
    end

    it "returns 4 records from the database" do
      event_response = json_response
      expect(event_response[:events]).to have(4).items
    end

    it { should respond_with 200 }
  end
    describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        user = FactoryGirl.create :user
        @event_attributes = FactoryGirl.attributes_for :event
        api_authorization_header user.auth_token
        post :create, { event: @event_attributes }
      end

      it "renders the json representation for the event record just created" do
        event_response = json_response
        expect(event_response[:title]).to eql @event_attributes[:title]
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        user = FactoryGirl.create :user
        @invalid_event_attributes = { title: "" }
        api_authorization_header user.auth_token
        post :create, { event: @invalid_event_attributes }
      end

      it "renders an errors json" do
        event_response = json_response
        expect(event_response).to have_key(:errors)
      end

      it "renders the json errors on why the user could not be created" do
        event_response = json_response
        expect(event_response[:errors][:title]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end
  
     describe "PUT/PATCH #update" do
    before(:each) do
      @user = FactoryGirl.create :user
      @event = FactoryGirl.create :event
      api_authorization_header @user.auth_token
    end

    context "when is successfully updated" do
      before(:each) do
        patch :update, {id: @event.id,
              event: { title: "Moon Walker" } }
      end

      it "renders the json representation for the updated person" do
        event_response = json_response
        expect(event_response[:title]).to eql "Moon Walker"
      end

      it { should respond_with 202 }
    end

    context "when is not updated" do
      before(:each) do
        patch :update, {id: @event.id,
              event: { title: "" } }
      end

      it "renders an errors json" do
        event_response = json_response
        expect(event_response).to have_key(:errors)
      end

      it "renders the json errors on why the person could not be updated" do
        event_response = json_response
        expect(event_response[:errors][:title]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end
  
   describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryGirl.create :user
      @event = FactoryGirl.create :event
      api_authorization_header @user.auth_token
      delete :destroy, {id: @event.id }
    end

    it { should respond_with 204 }
  end
  describe 'get a month' do
    context 'no events' do
      before(:each) do
      post :calendar, {
        event: {year: "2015", month:"04", day: "01", type: "month"}}
      end
      it 'should have 5 whole weeks' do
        calendar_response = json_response
        expect(calendar_response).to have(35).items
        expect(calendar_response[1][:events]).to have(0).items
      end
      it { should respond_with 200 }
    end

    
  end

  describe 'get a week' do
    context 'no events' do
      before(:each) do
      post :calendar, {
        event: {year: "2015", month:"04", day: "01", type: "week"}}
      end
      it 'should have 1 whole week' do
        calendar_response = json_response
        expect(calendar_response).to have(7).items
        expect(calendar_response[1][:events]).to have(0).items
      end
      it { should respond_with 200 }      
    end
  
  end  

  describe 'get a day' do
    context 'no events' do
      before(:each) do
      post :calendar, {
        event: {year: "2015", month:"04", day: "01", type: "day"}}
      end
      it 'should have 1 day' do
        calendar_response = json_response
        expect(calendar_response).to have(1).items
        expect(calendar_response[0][:events]).to have(0).items
      end
      it { should respond_with 200 }      
    end
    context 'with events' do
      before(:each) do
        @event1 = FactoryGirl.create :event, eventdate: '2015-04-01' 
        @event2 = FactoryGirl.create :event, eventdate: '2015-04-01'
        @event3 = FactoryGirl.create :event, eventdate: '2015-04-01'
        @event4 = FactoryGirl.create :event, eventdate: '2015-04-08'        
      post :calendar, {
        event: {year: "2015", month:"04", day: "01", type: "day"}}
      end
      it 'should have 1 day' do
        calendar_response = json_response
        expect(calendar_response).to have(1).items
        expect(calendar_response[0][:events]).to have(3).items
      end
      it { should respond_with 200 }       
    end    
  end
end

