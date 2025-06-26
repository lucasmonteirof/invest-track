module Br
  class Company < ApplicationRecord
    self.table_name = "br_companies"

    has_many :stocks, class_name: "Br::Stock", dependent: :destroy

    validates :name, :cnpj, presence: true, uniqueness: { case_sensitive: false }
  end
end
