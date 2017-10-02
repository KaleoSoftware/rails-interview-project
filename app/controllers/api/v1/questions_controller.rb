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
    unless api_key_from_query_params || api_key_from_basic_auth
      render json: {}, status: 401
      return false
    end
  end

  def api_key_from_query_params
    if secure_compare(params[:api_key])
      @tenant = Tenant.where(api_key: params[:api_key]).first
      return true
    end
    return false
  end

  def api_key_from_basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      if secure_compare(password)
        @tenant = Tenant.find_by_api_key(password)
        return true
      end
      return false
    end
  end

  def increment_api_counter
    authorize unless @tenant
    if @tenant
      @tenant.api_count += 1
      @tenant.save
    end
  end

  def secure_compare(their_token)
    tokens = Tenant.all.pluck(:api_key)
    tokens.shuffle.map{|our_token|
      ActiveSupport::SecurityUtils.secure_compare(our_token, their_token) if their_token
     }.include?(true)
  end

end
