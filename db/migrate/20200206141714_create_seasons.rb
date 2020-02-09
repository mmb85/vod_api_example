class CreateSeasons < ActiveRecord::Migration[6.0]
  def change
    create_table :seasons do |t|
      t.string :title
      t.string :plot
      t.integer :number

      t.timestamps
    end
  end
end
