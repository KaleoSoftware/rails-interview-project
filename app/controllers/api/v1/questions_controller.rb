class API::V1::QuestionsController < ApplicationController
  before_filter :authorize

  def index
    @questions = Question.public_questions
  end

  def show
    @question = Question.public_questions.find( params[:id] )
  end

  private

  def authorize
    @tenant = Tenant.where(api_key: params[:api_key]).first
    unless @tenant || use_basic_auth
      render json: {}, status: 401
      return false
    end
    increment_api_counter
  end

  def use_basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      @tenant = Tenant.find_by_api_key(password)
      @tenant.api_key == password
    end
  end

  def increment_api_counter
    if @tenant
      @tenant.api_count += 1
      @tenant.save
    end
  end

end

