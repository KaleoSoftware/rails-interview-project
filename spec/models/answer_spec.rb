# frozen_string_literal: true

require 'rails_helper'

# Test suite for the Answer model
RSpec.describe Answer, type: :model do
  # Association test
  # ensure the Answer belongs to a Question and an Answerer (User)
  it { should belong_to(:question) }
  it { should belong_to(:answerer) }

  subject { create(:answer) }

  it 'is valid' do
    expect(subject).to be_valid
  end

  it 'has a body' do
    expect(subject.body).not_to be_nil
  end

  it 'has an answerer' do
    expect(subject.answerer).to be_a(User)
  end

  it 'has a question' do
    expect(subject.question).to be_a(Question)
  end

  # before(:each) do
  #   @answer = create(:answer)
  # end

  # it "has a body" do
  #     expect(@answer.body).not_to be_nil
  # end

  # describe "relationships" do
  #     it "belongs to an answerer" do

  #         expect(@answer.answerer).to be_a(User)
  #     end

  #     it "belongs to a question" do

  #         expect(@answer.question).to be_a(Question)
  #     end
end
