require 'spec_helper'

describe PeopleRole do
  let(:people_role) { FactoryGirl.build :people_role }
  subject { people_role }

  it { should respond_to :person_id }
  it { should respond_to :role_id }


  it { should belong_to :person }
  it { should belong_to :role }
end
