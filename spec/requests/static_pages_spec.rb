# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'StaticPages', type: :request do
  describe 'GET /help' do
    it 'renders a successful response' do
      get '/static_pages/help'
      assert_select 'title', 'Help | Sample App'
      expect(response).to be_successful
    end
  end

  describe 'GET /about' do
    it 'renders a successful response' do
      get '/static_pages/about'
      assert_select 'title', 'About | Sample App'
      expect(response).to be_successful
    end
  end

  describe "root 'static_pages#home'" do
    it 'renders a successful response' do
      get '/'
      assert_select 'title', 'Home | Sample App'
      expect(response).to be_successful
    end
  end
end
