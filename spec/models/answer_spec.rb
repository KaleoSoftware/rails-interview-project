# frozen_string_literal: true

require 'rails_helper'

# Test suite for the Answer model
RSpec.describe Answer, type: :model do
  # Association test
  # ensure the Answer belongs to a Question and an Answerer (User)
  it { should belong_to(:question) }
  it { should belong_to(:answerer) }
end
