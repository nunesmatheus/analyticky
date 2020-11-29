# frozen_string_literal: true

Rails.application.routes.draw do
  resources :events, only: :create

  # API Documentation
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
end
