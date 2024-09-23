# frozen_string_literal: true

User.create!(
  name: 'Walter White',
  email: 'haizenberg@albuqerke.com',
  password: 'foobar',
  password_confirmation: 'foobar',
  admin: true,
  activated: true,
  activated_at: Time.zone.now
)

99.times do |_n|
  name = FFaker::Name.name
  email = FFaker::Internet.email
  password = 'password'
  User.create!(
    name:,
    email:,
    password:,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now
  )
end
