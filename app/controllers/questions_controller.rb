# frozen_string_literal: true

# Questions controller
class QuestionsController < ApplicationController
  def index
    @public_questions = Question.public_question.count
    @private_questions = Question.private_question.count
    @answers = Answer.count
    @users = User.count
    @tenants = Tenant.all
    @tenants_count = Tenant.count
  end

  def show
    @questions = Question.all
    render json: @questions
    # @tenants = Tenant.all
    # render json: @tenants
  end
end
