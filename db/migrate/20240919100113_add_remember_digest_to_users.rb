# frozen_string_literal: true

class AddRememberDigestToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :remember_digest, :string
  end
end
