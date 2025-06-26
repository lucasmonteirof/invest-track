ActiveRecord::Schema[8.0].define(version: 2025_06_18_183418) do
  create_table "br_companies", force: :cascade do |t|
    t.string "name"
    t.string "cnpj"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "br_stocks", force: :cascade do |t|
    t.string "ticker"
    t.decimal "price"
    t.integer "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_br_stocks_on_company_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "login"
    t.string "password"
    t.string "name"
    t.date "date_of_birth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  add_foreign_key "br_stocks", "br_companies", column: "company_id"
end
