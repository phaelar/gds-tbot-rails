FactoryGirl.define do
  factory :hashtag do
    name "somename"

    trait :with_message do
      after(:build) do |hastag|
        hashtag.messages << create(:messages, hashtag: hashtag)
      end
    end
  end
end
