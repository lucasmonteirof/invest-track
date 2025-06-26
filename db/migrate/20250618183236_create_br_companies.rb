class CreateBrCompanies < ActiveRecord::Migration[8.0]
  def change
    create_table :br_companies do |t|
      t.string :name
      t.string :cnpj

      t.timestamps
    end
  end
end
