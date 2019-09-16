# frozen_string_literal: true

# ApplicationController provides basic functionality and security to child controllers
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  class ApiKeyAuthorizationError < StandardError
  end

  rescue_from(ApiKeyAuthorizationError) do
    render status: :unauthorized, json: { status: 401, error: I18n.t('unauthorized') }
  end

  rescue_from(ActionController::ParameterMissing) do |e|
    render status: :bad_request, json: {  status: 400, error: "#{I18n.t('parameter_missing')}: #{e.param}" }
  end
end
