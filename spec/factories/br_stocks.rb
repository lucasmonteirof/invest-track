FactoryBot.define do
  factory :br_stock, class: "Br::Stock" do
    ticker { "ABCD3" }
    price { 12.34 }
    association :company, factory: :br_company
  end
end
