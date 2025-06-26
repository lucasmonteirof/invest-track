require "rails_helper"

RSpec.describe Br::Stock, type: :model do
  subject { create(:br_stock) }

  it { should belong_to(:company).class_name("Br::Company") }

  it { should validate_presence_of(:ticker) }
  it { should validate_presence_of(:price) }

  it { should validate_uniqueness_of(:ticker).case_insensitive }
end
