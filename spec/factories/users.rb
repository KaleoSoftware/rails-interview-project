# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { FFaker::Name.name }
  end
end
