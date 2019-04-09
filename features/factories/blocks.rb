FactoryBot.define do
  factory :block do
    kind  { rand(1..13) }
    side  { [:left, :right].sample }
    sequence(:position) { |position| position }
    portfolio
  end
end