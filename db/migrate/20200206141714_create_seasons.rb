class CreateSeasons < ActiveRecord::Migration[6.0]
  def change
    create_table :seasons do |t|
      t.string :title, null: false
      t.string :plot
      t.integer :number, null: false

      t.timestamps
    end
  end
end
