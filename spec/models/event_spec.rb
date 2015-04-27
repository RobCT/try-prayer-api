require 'spec_helper'

describe Event do
  let(:event) { FactoryGirl.build :event }
  subject { event }
    it { should respond_to(:title) }
    it { should respond_to(:eventdate) }
    it { should respond_to(:eventstart) }
    it { should respond_to(:eventend) }
    it { should validate_presence_of :eventdate}
    it { should validate_presence_of :eventstart }
    it { should validate_presence_of :eventend }
    it { should validate_presence_of :title }
    it { should have_many :volunteersheets }
    describe ' filter by date range ' do
      before(:each) do
        @event1 = FactoryGirl.create :event, eventdate: '2015-03-02' 
        @event2 = FactoryGirl.create :event, eventdate: '2015-03-08'
        @event3 = FactoryGirl.create :event, eventdate: '2015-04-02'
        @event4 = FactoryGirl.create :event, eventdate: '2015-04-08'
        
      end
        it "returns the events between the date range" do
          expect(Event.filter_by_date('2015-03-07', '2015-04-03').sort).to match_array([@event2, @event3])
       end
      
      
    end
    
    describe 'filter by date' do
      before(:each) do
        @event1 = FactoryGirl.create :event, eventdate: '2015-03-02' 
        @event2 = FactoryGirl.create :event, eventdate: '2015-03-08'
        @event3 = FactoryGirl.create :event, eventdate: '2015-04-02'
        @event4 = FactoryGirl.create :event, eventdate: '2015-04-08'
        
      end
        it "returns the events with date" do
          expect(Event.filter_by_single_date('2015-04-02')).to match_array([@event3])
       end    
    end
    
    describe 'filter by id' do
      before(:each) do
        @event1 = FactoryGirl.create :event
        @event2 = FactoryGirl.create :event
        @event3 = FactoryGirl.create :event
        @event4 = FactoryGirl.create :event
         
      end
        it "returns the event with id" do
          expect(Event.filter_by_single_id(@event3[:id])).to match_array([@event3])
       end        
    end
end

