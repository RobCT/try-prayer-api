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
   
    describe "GET #show_roles" do
      before(:each) do
        @person  = FactoryGirl.create :person
        @role1 = FactoryGirl.create :role
        @role2 = FactoryGirl.create :role
        @person.roles << @role1
        @person.roles << @role2
        get :show_roles, id: @person.id
      end
      
      it "returns the roles for the person as an array in a hash" do
        person_response = json_response
        expect(person_response[:people].length).to eql 2
      end
      it { should respond_with 200 }
    end
      
      

    describe "GET #index" do
    before(:each) do
      4.times { FactoryGirl.create :person }
      get :index
    end

    it "returns 4 records from the database" do
      people_response = json_response
      expect(people_response[:people]).to have(4).items
    end

    it { should respond_with 200 }
  end
    describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        user = FactoryGirl.create :user
        @person_attributes = FactoryGirl.attributes_for :person
        api_authorization_header user.auth_token
        post :create, { person: @person_attributes }
      end

      it "renders the json representation for the product record just created" do
        person_response = json_response
        expect(person_response[:lastname]).to eql @person_attributes[:lastname]
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        user = FactoryGirl.create :user
        @invalid_person_attributes = { firstname: "Andy" }
        api_authorization_header user.auth_token
        post :create, { person: @invalid_person_attributes }
      end

      it "renders an errors json" do
        person_response = json_response
        expect(person_response).to have_key(:errors)
      end

      it "renders the json errors on why the user could not be created" do
        person_response = json_response
        expect(person_response[:errors][:lastname]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end
  
  describe "POST #add_role" do
    before(:each) do
      @user = FactoryGirl.create :user
      @role = FactoryGirl.create :role
      @person = FactoryGirl.create :person
      api_authorization_header @user.auth_token
      post :add_role, {id: @person.id, role_id: @role.id}
    end
      it "returns the roles for the person as an array in a hash" do
        person_response = json_response
        expect(person_response[:people].length).to eql 1
        expect(person_response[:people][0][:description]).to eql @role.description
      end
      it { should respond_with 203 }
  end
  
     describe "PUT/PATCH #update" do
    before(:each) do
      @user = FactoryGirl.create :user
      @person = FactoryGirl.create :person
      api_authorization_header @user.auth_token
    end

    context "when is successfully updated" do
      before(:each) do
        patch :update, {id: @person.id,
              person: { lastname: "Pinkerton Bott" } }
      end

      it "renders the json representation for the updated person" do
        person_response = json_response
        
        expect(person_response[:lastname]).to eql "Pinkerton Bott"
      end

      it { should respond_with 202 }
    end

    context "when is not updated" do
      before(:each) do
        patch :update, {id: @person.id,
              person: { lastname: "" } }
      end

      it "renders an errors json" do
        person_response = json_response
        expect(person_response).to have_key(:errors)
      end

      it "renders the json errors on why the person could not be updated" do
        person_response = json_response
        expect(person_response[:errors][:lastname]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end
  
   describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryGirl.create :user
      @person = FactoryGirl.create :person
      api_authorization_header @user.auth_token
      delete :destroy, {id: @person.id }
    end

    it { should respond_with 204 }
  end
  describe "DELETE #remove_role" do
    before(:each) do
      @user = FactoryGirl.create :user
      @role = FactoryGirl.create :role
      @person = FactoryGirl.create :person
      api_authorization_header @user.auth_token 
      @person.roles << @role    
    end
    context "role added" do
      before(:each) do
        get :show_roles, id: @person.id
      end
       it "returns the roles for the person as an array in a hash" do
        person_response = json_response
        expect(person_response[:people].length).to eql 1
       end
     end
     context "role removed" do
       before(:each) do
        delete :remove_role, {id: @person.id, role_id: @role.id}
       end
        it "returns the roles for the person as an array in a hash" do
        person_response = json_response
        expect(person_response[:people].length).to eql 0
        
       end
       it { should respond_with 203 }
      
    end
  end
end
