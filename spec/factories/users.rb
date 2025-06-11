FactoryBot.define do
    factory :user do
        login { "johndoe" }
        name { "John Doe" }
        password { "password123" }
        date_of_birth { Date.new(1980, 10, 19) }
    end
end
