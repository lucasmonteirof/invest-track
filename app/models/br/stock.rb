module Br
  class Stock < ApplicationRecord
    self.table_name = "br_stocks"

    belongs_to :company, class_name: "Br::Company"

    validates :price, presence: true
    validates :ticker, presence: true, uniqueness: { case_sensitive: false }
  end
end
