# frozen_string_literal: true

require 'rails_helper'

# Test suite for the Question model
RSpec.describe Question, type: :model do
  # Association test
  # ensure Question model has a 1:m relationship with the Answer model
  it { should have_many(:answers).dependent(:destroy) }
  # ensure the Question belongs to an Asker (User)
  it { should belong_to(:asker) }
end
