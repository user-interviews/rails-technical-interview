FactoryBot.define do
  sequence :email do |n|
    "email+#{n}@test.com"
  end

  factory :project do
    association :user

    internal_name 'Project [NAME]'
    public_title 'Project [TITLE]'

    compensation_amount 100
    interview_type :in_person
    requested_participants 10

    trait :launched do
      launched_at Time.zone.now
    end

    trait :charged do
      launched_at Time.zone.now - 1.week
      charged_at Time.zone.now
    end
  end

  factory :user do
    email
    first_name 'Test'
    last_name 'User'
    password 'password'
  end

  factory :user_remember_token do
    association :user
    last_used_at Time.zone.now

    transient do
      token 'token'
    end

    after(:build, :stub) do |remember_token, evaluator|
      remember_token.token_digest = UserRememberToken.create_digest(evaluator.token)
    end
  end
end
