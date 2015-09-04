FactoryGirl.define do
  factory :member do
    sequence(:email) { |n| "magnus#{n}@#{n}man.com" }
    first_name 'Spoot'
    last_name 'Bean'
  end
end
