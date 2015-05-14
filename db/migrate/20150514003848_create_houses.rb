class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.string :title, default: ""
      t.decimal :price, default: 0.0
      t.boolean :published, default: false
      t.datetime :date_published
      t.integer :user_id

      t.timestamps
    end
    add_index :houses, :user_id
  end
end
