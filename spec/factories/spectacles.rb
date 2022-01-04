FactoryBot.define do
  factory :spectacle do
    sequence(:name) { |i| "Name #{i}" }
    period { (Date.today - 1.days)..Date.today }
  end
end
