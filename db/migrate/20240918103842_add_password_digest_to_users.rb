# frozen_string_literal: true

class AddPasswordDigestToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :password_digest, :string
  end
end
