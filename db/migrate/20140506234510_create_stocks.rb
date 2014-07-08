class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.date :date
      t.decimal :open
      t.decimal :high
      t.decimal :low
      t.decimal :close

      t.timestamps
    end
  end
end
