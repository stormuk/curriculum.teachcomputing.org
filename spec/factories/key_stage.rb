FactoryBot.define do
  factory :key_stage do
    sequence(:level, &:to_s)
    sequence(:description) { |n| "Key Stage 3, or KS3, is the part taught to children between the ages of 11 and 14. KS3 begins when pupils start secondary education - #{n}" }
    sequence(:ages) { |n| "#{n}-#{n + 2}" }
    sequence(:years) { |n| "#{n}-#{n + 2}" }
    state

    factory :published_key_stage do
      state factory: :published_state
    end
  end
end
