class User < ApplicationRecord
    has_secure_password

    has_one :portfolio, dependent: :destroy

    validates :password, :name, :date_of_birth, presence: true
    validates :login, presence: true, uniqueness: { case_sensitive: false }
end
