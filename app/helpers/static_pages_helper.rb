# frozen_string_literal: true

module StaticPagesHelper # rubocop:disable Style/Documentation
  def full_title(page_title = '')
    page_title.present? ? "#{page_title} | Sample App" : 'Sample App'
  end
end
