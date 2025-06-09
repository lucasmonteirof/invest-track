class User < ApplicationRecord
  def age
    today = Date.today
    age = today.year - date_of_birth.year
    
    birthday_this_year = Date.new(today.year, date_of_birth.month, date_of_birth.day)
    age -= 1 if today < birthday_this_year
    
    age
  end
end
