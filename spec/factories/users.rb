FactoryBot.define do
  factory :user do
    name { FFaker::Name.name}
    email { FFaker::Internet.email }
    password { 'foobar' }
    password_confirmation { 'foobar' }
  end
end
