FactoryBot.define do
  factory :br_company, class: "Br::Company" do
    name { "Fake Co." }
    cnpj { "12345678000100" }
  end
end
