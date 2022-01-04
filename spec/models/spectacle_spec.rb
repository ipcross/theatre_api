RSpec.describe Spectacle, type: :model do
  subject(:spectacle) { create(:spectacle) }

  context "Validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :period }
  end

  describe '#from_range' do
    it "should return spectacle" do
      expect(spectacle).to eq Spectacle.from_range(Date.today..Date.today).first
    end
    it "should return empty" do
      range = (Date.today - 5.days)..(Date.today - 4.days)
      expect(Spectacle.from_range(range)).to eq []
    end
  end
end
