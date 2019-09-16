# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    body { FFaker::HipsterIpsum.sentence }
    answerer { User.create(name: FFaker::Name.name) }
    question
  end
end
