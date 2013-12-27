FactoryGirl.define do
  factory :user do
    first_name 'Guy'
    last_name 'Smiley'
    phone '312-867-5309'
    email 'guy@smiley.com'
    password '123456'
    password_confirmation '123456'
  end
end
