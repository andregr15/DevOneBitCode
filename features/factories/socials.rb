FactoryBot.define do
  factory :social do
    kind { [:facebook, :twitter, :linkedin, :github, :instagram].sample }
    url { FFaker::Internet.http_url }
    portfolio
  end
end