# frozen_string_literal: true

# Questions can have multiple answers, belong to one asker, and may be private
class Question < ActiveRecord::Base
  has_many :answers
  belongs_to :asker, class_name: 'User', foreign_key: :user_id
end
