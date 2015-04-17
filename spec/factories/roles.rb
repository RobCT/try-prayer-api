FactoryGirl.define do
  factory :role do
    description { FFaker::Job.title }
  end

end
