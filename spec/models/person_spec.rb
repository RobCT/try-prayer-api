require 'spec_helper'

describe Person do
    let(:person) { FactoryGirl.build :person }
  subject { person }
  it { should respond_to(:firstname) }
  it { should respond_to(:lastname) }
   it { should validate_presence_of :firstname }
    it { should validate_presence_of :lastname }
      it { should have_and_belong_to_many(:roles) }
end
