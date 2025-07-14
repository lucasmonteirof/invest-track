require "rails_helper"

RSpec.describe Portfolio, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:positions).dependent(:destroy) }
  it { should have_many(:stocks).through(:positions).class_name("Br::Stock") }
end
