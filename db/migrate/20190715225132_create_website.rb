class CreateWebsite < ActiveRecord::Migration[5.2]
  def change
    create_table :websites do |t|
      t.string :title
      t.integer :access_count
    end
  end
end
