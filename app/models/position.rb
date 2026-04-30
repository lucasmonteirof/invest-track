class Position < ApplicationRecord
  belongs_to :portfolio
  belongs_to :stock, class_name: "Br::Stock"

  validates :quantity, :average_price, presence: true
end
