# frozen_string_literal: true

# Answers belong to one question and one answerer
class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :answerer, class_name: 'User', foreign_key: :user_id
end
