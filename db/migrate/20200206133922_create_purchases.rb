class CreatePurchases < ActiveRecord::Migration[6.0]
  def change
    create_table :purchases do |t|
      t.belongs_to :movie
      t.belongs_to :season
      t.belongs_to :user, null: false
      t.float :price, null: false
      t.integer :quality, null: false

      t.timestamps
    end
  end
end