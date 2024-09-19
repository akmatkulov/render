# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe 'validates user name' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(50) }
  end

  describe 'validates email user' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { is_expected.to allow_value('user@example.com').for(:email) }
    it { is_expected.to validate_length_of(:email).is_at_most(150) }
  end

  it 'is valid with a name, email, and password' do
    expect(user).to be_valid
  end

  it 'is invalid without a name' do
    user = described_class.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  it 'is invalid without an email' do
    user = described_class.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it 'is invalid without a password' do
    user = described_class.new(password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end

  it 'is invalid with a duplicate email address' do
    described_class.create!(
      name: 'Tanya McQuoid',
      email: 'tanya@thewhitelotus.com',
      password: 'yougotthis'
    )
    user = described_class.new(
      name: 'Shane',
      email: 'tanya@thewhitelotus.com',
      password: 'pineappleroom'
    )
    user.valid?
    expect(user.errors[:email]).to include('has already been taken')
  end
end
