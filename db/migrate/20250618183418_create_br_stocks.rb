class CreateBrStocks < ActiveRecord::Migration[8.0]
  def change
    create_table :br_stocks do |t|
      t.string :ticker
      t.decimal :price
      t.references :company, null: false, foreign_key: { to_table: :br_companies }

      t.timestamps
    end
  end
end
