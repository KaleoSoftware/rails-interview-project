# frozen_string_literal: true

# Questions controller
class QuestionsController < ApplicationController
  # Return all public questions and their associated answers
  # a valid tenant api_key must be provided
  def index
    params.require(:api_key)
    validate_api_key(params[:api_key])

    questions_with_answers = generate_question_json

    render json: { questions: questions_with_answers }.to_json
  end

  # Statistics dashboard
  def statistics
    @public_questions = Question.public_question.count
    @private_questions = Question.private_question.count
    @answers = Answer.count
    @users = User.count
    @tenants = Tenant.all
    @tenants_count = Tenant.count
  end

  private

  def validate_api_key(api_key)
    tenant = Tenant.find_by(api_key: api_key)
    raise ApiKeyAuthorizationError unless tenant

    # if a valid api key, update corresponding tenant's request count
    tenant.update_attribute(:request_count, tenant.request_count + 1)
  end

  def generate_question_json
    questions = Question.public_question
    questions_with_answers = questions.map do |question|
      answers = Answer.where(question_id: question.id)
      associated_answers = answers.map do |answer|
        { id: answer.id, answer: answer.body }
      end
      { id: question.id, question: question.title, answers: associated_answers }
    end
    questions_with_answers
  end
end
