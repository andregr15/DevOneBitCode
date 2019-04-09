FactoryBot.define do
  factory :block do
    kind  { rand(1..12) }
    side  { [:left, :right].sample }
    sequence(:position) { |position| position }
    portfolio
  end
end