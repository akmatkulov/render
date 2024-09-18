require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  describe 'validates user name' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(50) }
  end

  describe 'validates email user' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { should allow_value('user@example.com').for(:email) }
    it { should validate_length_of(:email).is_at_most(150) }
  end

  it 'is valid with a name, email, and password' do
    expect(user).to be_valid
  end

  it 'is invalid without a name' do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  it 'is invalid without an email' do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it 'is invalid without a password' do
    user = User.new(password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end

  it 'is invalid with a duplicate email address' do
    User.create!(
      name: 'Tanya McQuoid',
      email: 'tanya@thewhitelotus.com',
      password: 'yougotthis'
    )
    user = User.new(
      name: 'Shane',
      email: 'tanya@thewhitelotus.com',
      password: 'pineappleroom'
    )
    user.valid?
    expect(user.errors[:email]).to include('has already been taken')
  end
end
