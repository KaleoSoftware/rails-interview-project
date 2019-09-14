# frozen_string_literal: true

class User < ActiveRecord::Base
  has_many :questions, inverse_of: :asker
  has_many :answers,   inverse_of: :answerer
end
