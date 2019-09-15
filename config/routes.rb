# frozen_string_literal: true

Rails.application.routes.draw do
  root 'questions#statistics'

  resources :questions, only: :index, defaults: { format: :json }
end
