require 'spec_helper'

describe Prayer do
  let(:prayer) { FactoryGirl.build :prayer }
  subject { prayer }
    it { should respond_to(:title) }
    it { should respond_to(:prayerdate) }
    it { should respond_to(:prayer) }
   
    it { should validate_presence_of :prayerdate}
    it { should validate_presence_of :prayer }

    

    describe ' filter by date range ' do
      before(:each) do
        @prayer1 = FactoryGirl.create :prayer, prayerdate: '2015-03-02' 
        @prayer2 = FactoryGirl.create :prayer, prayerdate: '2015-03-08'
        @prayer3 = FactoryGirl.create :prayer, prayerdate: '2015-04-02'
        @prayer4 = FactoryGirl.create :prayer, prayerdate: '2015-04-08'
        
      end
        it "returns the prayers between the date range" do
          expect(Prayer.filter_by_date('2015-03-07', '2015-04-03').sort).to match_array([@prayer2, @prayer3])
       end
      
      
    end
    
    describe 'filter by date' do
      before(:each) do
        @prayer1 = FactoryGirl.create :prayer, prayerdate: '2015-03-02' 
        @prayer2 = FactoryGirl.create :prayer, prayerdate: '2015-03-08'
        @prayer3 = FactoryGirl.create :prayer, prayerdate: '2015-04-02'
        @prayer4 = FactoryGirl.create :prayer, prayerdate: '2015-04-08'
        
      end
        it "returns the prayers with date" do
          expect(Prayer.filter_by_single_date('2015-04-02')).to match_array([@prayer3])
       end    
    end
    
    describe 'filter by id' do
      before(:each) do
        @prayer1 = FactoryGirl.create :prayer
        @prayer2 = FactoryGirl.create :prayer
        @prayer3 = FactoryGirl.create :prayer
        @prayer4 = FactoryGirl.create :prayer
         
      end
        it "returns the prayer with id" do
          expect(Prayer.filter_by_single_id(@prayer3[:id])).to match_array([@prayer3])
       end        
    end
end

