class User < ApplicationRecord
    validates :password, :name, :date_of_birth, presence: true
    validates :login, presence: true, uniqueness: { case_sensitive: false }
end
