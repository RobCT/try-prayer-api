require 'spec_helper'

describe Volunteersheet do
  let(:volunteersheet) { FactoryGirl.build :volunteersheet }
  subject { volunteersheet }
  it { should respond_to(:about) }
  it { should respond_to(:rowindex) }
  it { should validate_presence_of(:about) }
  it { should validate_presence_of(:rowindex) }
  it { should belong_to :role }
  it { should belong_to :person }
  it { should belong_to :event }
  
end
