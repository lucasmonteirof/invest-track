class CreateBrStocks < ActiveRecord::Migration[8.0]
  def change
    create_table :br_stocks do |t|
      t.string :ticker
      t.decimal :price
      t.references :br_companies, null: false, foreign_key: true

      t.timestamps
    end
  end
end
