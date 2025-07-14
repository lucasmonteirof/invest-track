class Portfolio < ApplicationRecord
  belongs_to :user
  has_many :positions, dependent: :destroy
  has_many :stocks, through: :positions, class_name: "Br::Stock"
end
