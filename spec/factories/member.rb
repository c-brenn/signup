FactoryGirl.define do
  factory :member do
    sequence(:email) { |n| "magnus#{n}@#{n}man.com" }
    first_name 'Spoot'
    last_name 'Bean'
    year Random.new.rand(1..5).to_i
  end
end
