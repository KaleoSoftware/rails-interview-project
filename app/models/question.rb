# frozen_string_literal: true

class Question < ActiveRecord::Base
  has_many :answers
  belongs_to :user
end
