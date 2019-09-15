# frozen_string_literal: true

# Questions controller
class QuestionsController < ApplicationController
  def index
    # @public_questions = Question.where(private_question: false).count
    # @private_questions = Question.where(private_question: true).count
    @public_questions = Question.public_question.count
    @private_questions = Question.private_question.count
    @answers = Answer.count
    @users = User.count
    @tenants = Tenant.all # TODO: tenant count goes here
  end

  def show
    @questions = Question.all
    render json: @questions
  end
end
