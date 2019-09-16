# frozen_string_literal: true

require 'rails_helper'

# Test suite for the Tenant model
RSpec.describe Tenant, type: :model do
  subject { create(:tenant) }

  it 'is valid' do
    expect(subject).to be_valid
  end

  it 'has a name' do
    expect(subject.name).not_to be_nil
  end

  it 'has an api_key' do
    expect(subject.api_key).not_to be_nil
  end

  it 'has a request_count that starts at 0' do
    expect(subject.request_count).to be(0)
  end
end
