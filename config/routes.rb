# frozen_string_literal: true

Rails.application.routes.draw do
  # get 'welcome/index'
  # root 'welcome#index'

  # get 'questions/index'
  root 'questions#index'

  get 'questions', to: 'questions#index'

  # resources :questions, only: %i[index show], defaults: { format: :json }
  resources :questions, only: %i[index show]
end
