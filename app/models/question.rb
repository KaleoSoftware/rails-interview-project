# frozen_string_literal: true

# Questions can have multiple answers, belong to one asker, and may be private
class Question < ActiveRecord::Base
  # private is a reserved keyword in ActiveRecord, hence the names ending with _question
  scope :private_question, -> { where(private_question: true) }
  scope :public_question, -> { where(private_question: false) }

  has_many :answers, dependent: :destroy
  belongs_to :asker, class_name: 'User', foreign_key: :user_id
end
