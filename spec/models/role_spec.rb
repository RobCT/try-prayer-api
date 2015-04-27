require 'spec_helper'

describe Role do
      let(:role) { FactoryGirl.build :role }
  subject { role }
  it { should respond_to(:description) }
  it { should validate_presence_of :description }
  it { should have_and_belong_to_many(:people) }
  it { should have_one(:volunteersheet) }
end
