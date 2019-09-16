# frozen_string_literal: true

require 'rails_helper'

# Test suite for the Question model
RSpec.describe Question, type: :model do
  # Association test
  # ensure Question model has a 1:m relationship with the Answer model
  it { should have_many(:answers).dependent(:destroy) }
  # ensure the Question belongs to an Asker (User)
  it { should belong_to(:asker) }

  subject { create(:question) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'has a title' do
    expect(subject.title).not_to be_nil
  end

  it 'has an asker' do
    expect(subject.asker).to be_a(User)
  end

  it 'has a privacy setting' do
    expect(subject.private_question).to be_in([true, false])
  end
end
