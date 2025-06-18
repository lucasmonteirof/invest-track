module Br
  class Stock < ApplicationRecord
    self.table_name = "br_stocks"
    belongs_to :company, class_name: "Br::Company"
  end
end
