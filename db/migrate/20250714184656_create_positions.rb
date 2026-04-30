class CreatePositions < ActiveRecord::Migration[8.0]
  def change
    create_table :positions do |t|
      t.references :portfolio, null: false, foreign_key: true
      t.references :stock, null: false, foreign_key: { to_table: :br_stocks }
      t.decimal :quantity
      t.decimal :average_price

      t.timestamps
    end
  end
end
