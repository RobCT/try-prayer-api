require 'spec_helper'

describe Api::V1::RolesController do
  describe "GET #show" do
    before(:each) do
      
      @role = FactoryGirl.create :role
      get :show, id: @role.id
    end

    it "returns the information about a reporter on a hash" do
      role_response = json_response
      expect(role_response[:description]).to eql @role.description
    end
    


    it { should respond_with 200 }
  end
    describe "GET #index" do
    before(:each) do
      4.times { FactoryGirl.create :role }
      get :index
    end

    it "returns 4 records from the database" do
      role_response = json_response
      expect(role_response[:roles]).to have(4).items
    end

    it { should respond_with 200 }
  end
    describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        user = FactoryGirl.create :user
        @role_attributes = FactoryGirl.attributes_for :role
        api_authorization_header user.auth_token
        post :create, { role: @role_attributes }
      end

      it "renders the json representation for the product record just created" do
        role_response = json_response
        expect(role_response[:description]).to eql @role_attributes[:description]
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        user = FactoryGirl.create :user
        @invalid_role_attributes = { description: "" }
        api_authorization_header user.auth_token
        post :create, { role: @invalid_role_attributes }
      end

      it "renders an errors json" do
        role_response = json_response
        expect(role_response).to have_key(:errors)
      end

      it "renders the json errors on why the user could not be created" do
        role_response = json_response
        expect(role_response[:errors][:description]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end
  
     describe "PUT/PATCH #update" do
    before(:each) do
      @user = FactoryGirl.create :user
      @role = FactoryGirl.create :role
      api_authorization_header @user.auth_token
    end

    context "when is successfully updated" do
      before(:each) do
        patch :update, {id: @role.id,
              role: { description: "Moon Walker" } }
      end

      it "renders the json representation for the updated person" do
        role_response = json_response
        expect(role_response[:description]).to eql "Moon Walker"
      end

      it { should respond_with 202 }
    end

    context "when is not updated" do
      before(:each) do
        patch :update, {id: @role.id,
              role: { description: "" } }
      end

      it "renders an errors json" do
        role_response = json_response
        expect(role_response).to have_key(:errors)
      end

      it "renders the json errors on why the person could not be updated" do
        role_response = json_response
        expect(role_response[:errors][:description]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end
  
   describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryGirl.create :user
      @role = FactoryGirl.create :role
      api_authorization_header @user.auth_token
      delete :destroy, {id: @role.id }
    end

    it { should respond_with 204 }
  end
end
