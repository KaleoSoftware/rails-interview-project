# frozen_string_literal: true

FactoryBot.define do
  factory :tenant do
    name { FFaker::Company.name }
  end
end
