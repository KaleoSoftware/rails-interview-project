# frozen_string_literal: true

require 'rails_helper'

# Test suite for the User model
RSpec.describe User, type: :model do
  # Association test
  # ensure User model has a 1:m relationship with the Answer and Question models
  it { should have_many(:questions).dependent(:destroy) }
  it { should have_many(:answers).dependent(:destroy) }

  subject { create(:user) }

  it 'is valid' do
    expect(subject).to be_valid
  end

  it 'has a body' do
    expect(subject.name).not_to be_nil
  end
end
