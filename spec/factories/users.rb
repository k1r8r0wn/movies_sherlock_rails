FactoryGirl.define do
  factory :user do
    first_name 'John'
    last_name 'Doe'
    sequence :email do |n|
      "person#{n}@example.com"
    end
    password '12345678'
    password_confirmation '12345678'
  end
end
