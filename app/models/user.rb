class User < ApplicationRecord
  def age
    today = Date.today
    age = today.year - date_of_birth.year

    if today.month < date_of_birth.month
      if today.day < date_of_birth.day
        age -= 1
      end
    end
    
    age
  end
end
