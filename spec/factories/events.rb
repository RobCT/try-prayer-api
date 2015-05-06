FactoryGirl.define do
  factory :prayer do
    title { FFaker::Conference.name }
    prayerdate { FFaker::Time.date }
    prayer "A simple prayer"
    
  end

end
