class API::V1::QuestionsController < ApplicationController
  before_filter :authorize, :increment_api_counter

  def index
    @questions = Question.public_questions
  end

  def show
    @question = Question.public_questions.find( params[:id] )
  end

  private

  def authorize
    @tenant = Tenant.where(api_key: params[:api_key]).first
    unless @tenant
      render json: {}, status: 401
      return false
    end
  end

  def increment_api_counter
    if @tenant
      @tenant.api_count += 1
      @tenant.save
    end
  end

end

