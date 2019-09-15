# frozen_string_literal: true

Rails.application.routes.draw do
  root 'questions#index'

  # TEMPORARY
  get 'questions/tenants', to: 'questions#tenants'

  resources :questions, only: %i[index show]
end
