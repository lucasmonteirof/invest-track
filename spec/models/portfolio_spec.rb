require "rails_helper"

RSpec.describe Portfolio, type: :model do
  it { should belong_to(:user) }
end
