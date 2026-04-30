require "rails_helper"

RSpec.describe Position, type: :model do
  it { should belong_to(:portfolio) }
  it { should belong_to(:stock).class_name("Br::Stock") }

  it { should validate_presence_of(:quantity) }
  it { should validate_presence_of(:average_price) }
end
