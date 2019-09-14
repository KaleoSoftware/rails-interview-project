# frozen_string_literal: true

class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
end
