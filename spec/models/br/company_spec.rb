require "rails_helper"

RSpec.describe Br::Company, type: :model do
  let(:company) { create(:br_company) }
  let!(:stock) { create(:br_stock, company: company) }

  it { should have_many(:stocks).class_name("Br::Stock") }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:cnpj) }

  it { should validate_uniqueness_of(:name).case_insensitive }
  it { should validate_uniqueness_of(:cnpj).case_insensitive }

  it "destroys associated stocks when destroyed" do
    expect { company.destroy }.to change { Br::Stock.count }.by(-1)
  end
end
