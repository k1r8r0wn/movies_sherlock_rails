FactoryGirl.define do
  factory :user do
    first_name 'John'
    last_name 'Doe'
    email 'john@doe.com'
    password '12345'
    password_confirmation '12345'
  end
end
