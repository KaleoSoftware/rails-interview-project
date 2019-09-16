# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    title { FFaker::HipsterIpsum.sentence.gsub(/\.$/, '?') }
    asker { User.create(name: FFaker::Name.name) }
    private_question { FFaker::Boolean.random }
  end
end
