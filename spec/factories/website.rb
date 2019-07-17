# frozen_string_literal: true

FactoryBot.define do
  factory :website do
    url { Faker::Internet.url }
    access_count { rand(0..1000) }
  end
end
