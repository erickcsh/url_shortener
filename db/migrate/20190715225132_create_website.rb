# frozen_string_literal: true

class CreateWebsite < ActiveRecord::Migration[5.2]
  def change
    create_table :websites do |t|
      t.string :title
      t.string :url
      t.integer :access_count, default: 0
      t.timestamps
    end
  end
end
