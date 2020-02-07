class AddExpiredFlagToPurchases < ActiveRecord::Migration[6.0]
  def change
    add_column :purchases, :expired, :boolean, :default => false
  end
end
