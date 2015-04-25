FactoryGirl.define do
  factory :event do
    title { FFaker::Conference.name }
    eventdate { FFaker::Time.date }
    eventstart "2000-01-01T10:00:00.000Z"
    eventend "2000-01-01T11:30:00.000Z"
  end

end
