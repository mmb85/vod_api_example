class CreateEpisodes < ActiveRecord::Migration[6.0]
  def change
    create_table :episodes do |t|
      t.string :title, null: false
      t.string :plot
      t.belongs_to :season, null: false, foreign_key: true
      t.integer :number

      t.timestamps
    end
  end
end
