# frozen_string_literal: true

# Questions controller
class QuestionsController < ApplicationController
  def index
    # @questions = Question.all
    # @answers = Answer.all
    # @users = User.all
    # @tenants = Tenant.all
  end

  def show
    @questions = Question.all
    render json: @questions
  end
end
