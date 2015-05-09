require 'spec_helper'

describe Api::V1::PrayersController do
  describe "GET #show" do
    before(:each) do
      @prayer = FactoryGirl.create :prayer
      user = FactoryGirl.create :user
      api_authorization_header user.auth_token
      
      get :show, id: @prayer.id
    end

    it "returns the information about a reporter on a hash" do
      prayer_response = json_response
      expect(prayer_response[:prayer]).to eql @prayer.prayer
    end
    


    it { should respond_with 200 }
  end
    describe "GET #index" do
    before(:each) do
      user = FactoryGirl.create :user
      api_authorization_header user.auth_token
      4.times { FactoryGirl.create :prayer }
      get :index
    end

    it "returns 4 records from the database" do
      prayer_response = json_response
      expect(prayer_response[:prayers]).to have(4).items
    end

    it { should respond_with 200 }
  end
    describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        user = FactoryGirl.create :user
        @prayer_attributes = FactoryGirl.attributes_for :prayer
        api_authorization_header user.auth_token
        post :create, { prayer: @prayer_attributes }
      end

      it "renders the json representation for the prayer record just created" do
        prayer_response = json_response
        expect(prayer_response[:title]).to eql @prayer_attributes[:title]
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        user = FactoryGirl.create :user
        @invalid_prayer_attributes = { prayer: "" }
        api_authorization_header user.auth_token
        post :create, { prayer: @invalid_prayer_attributes }
      end

      it "renders an errors json" do
        prayer_response = json_response
        expect(prayer_response).to have_key(:errors)
      end

      it "renders the json errors on why the user could not be created" do
        prayer_response = json_response
        expect(prayer_response[:errors][:prayer]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end
  
     describe "PUT/PATCH #update" do
    before(:each) do
      @user = FactoryGirl.create :user
      @prayer = FactoryGirl.create :prayer
      api_authorization_header @user.auth_token
    end

    context "when is successfully updated" do
      before(:each) do
        patch :update, {id: @prayer.id,
              prayer: { title: "Moon Walker" } }
      end

      it "renders the json representation for the updated person" do
        prayer_response = json_response
        expect(prayer_response[:title]).to eql "Moon Walker"
      end

      it { should respond_with 202 }
    end

    context "when is not updated" do
      before(:each) do
        patch :update, {id: @prayer.id,
              prayer: { prayer: "" } }
      end

      it "renders an errors json" do
        prayer_response = json_response
        expect(prayer_response).to have_key(:errors)
      end

      it "renders the json errors on why the person could not be updated" do
        prayer_response = json_response
        expect(prayer_response[:errors][:prayer]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end
  
   describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryGirl.create :user
      @prayer = FactoryGirl.create :prayer
      api_authorization_header @user.auth_token
      delete :destroy, {id: @prayer.id }
    end

    it { should respond_with 204 }
  end


 

  describe 'get a day' do
    context 'no prayers' do
      before(:each) do
      user = FactoryGirl.create :user
      api_authorization_header user.auth_token
      post :calendar, {
        prayer: {year: "2015", month:"04", day: "01", type: "day"}}
      end
      it 'should have 1 day' do
        calendar_response = json_response
        expect(calendar_response).to have(1).items
        expect(calendar_response[0][:prayers]).to have(0).items
      end
      it { should respond_with 200 }      
    end
    context 'with prayers' do
      before(:each) do
        user = FactoryGirl.create :user
      api_authorization_header user.auth_token
        @prayer1 = FactoryGirl.create :prayer, prayerdate: '2015-04-01', user_id: user[:id]
        @prayer2 = FactoryGirl.create :prayer, prayerdate: '2015-04-01', user_id: user[:id]
        @prayer3 = FactoryGirl.create :prayer, prayerdate: '2015-04-01', user_id: user[:id]
        @prayer4 = FactoryGirl.create :prayer, prayerdate: '2015-04-08', user_id: user[:id]        
      post :calendar, {
        prayer: {year: "2015", month:"04", day: "01", type: "day"}}
      end
      it 'should have 1 day' do
        calendar_response = json_response
        expect(calendar_response).to have(1).items
        expect(calendar_response[0][:prayers]).to have(3).items
      end
      it { should respond_with 200 }       
    end    
  end
end

