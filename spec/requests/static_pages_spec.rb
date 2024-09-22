# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'StaticPages', type: :request do
  describe 'layout links' do
    it 'links' do
      get root_path
      assert_select 'a', text: 'About', count: 1
      assert_select 'a', text: 'Contact', count: 1
      assert_select 'a', text: 'News', count: 1
    end
  end

  describe 'GET /help' do
    it 'renders a successful response' do
      get help_path
      assert_select 'title', 'Help | Sample App'
      expect(response).to be_successful
    end
  end

  describe 'GET /contact' do
    it 'renders a successful response' do
      get contact_path
      assert_select 'title', 'Contact | Sample App'
      expect(response).to be_successful
    end
  end

  describe 'GET /about' do
    it 'renders a successful response' do
      get about_path
      assert_select 'title', 'About | Sample App'
      expect(response).to be_successful
    end
  end

  describe "root 'static_pages#home'" do
    it 'renders a successful response' do
      get '/'
      assert_select 'title', 'Sample App'
      expect(response).to be_successful
    end
  end
end
