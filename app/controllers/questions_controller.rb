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

  # Endpoint to return all public questions and their associated answers
  def show
    questions = Question.public_question

    questions_with_answers = questions.map do |question|
      answers = Answer.where(question_id: question.id)
      associated_answers = answers.map do |answer|
        { id: answer.id, answer: answer.body }
      end
      { id: question.id, question: question.title, answers: associated_answers }
    end

    render json: { questions: questions_with_answers }.to_json
  end

  # Provide an endpoint to see ALL public questions
  def all
    @questions = Question.public_question
    render json: @questions
  end
end
