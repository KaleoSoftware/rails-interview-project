# frozen_string_literal: true

Rails.application.routes.draw do
  root 'questions#index'

  get 'questions', to: 'questions#index'

  # resources :questions, only: %i[index show], defaults: { format: :json }
  resources :questions, only: %i[index show]
end
