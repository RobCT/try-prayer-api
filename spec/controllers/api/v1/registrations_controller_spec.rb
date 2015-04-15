require 'spec_helper'

describe Api::V1::RegistrationsController do


  describe "POST #create" do

    context "when is successfully created" do
      before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
        @user_attributes = FactoryGirl.attributes_for :user
        post :create, { user: @user_attributes }
      end

      it "renders the json representation for the user record just created" do
        user_response = json_response[:user]
        expect(user_response[:email]).to eql @user_attributes[:email]
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @invalid_user_attributes = {
            password: "12345678",
            password_confirmation: "12345678"
          } #notice I'm not including the email
        post :create, { user: @invalid_user_attributes }
      end

      it "renders an errors json" do
        user_response = json_response
        expect(user_response[:success]).to be_false
      end

      it "renders the json errors on whye the user could not be created" do
        user_response = json_response
        expect(user_response[:info][:email]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end


end