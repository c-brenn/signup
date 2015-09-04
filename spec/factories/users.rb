FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "spoot#{n}@bean.com" }
    password 'magnusman420'
    password_confirmation 'magnusman420'    
  end
end
