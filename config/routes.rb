# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "home#index"
  get "search", to: "search#show"
  namespace :api do
    get "search", to: "search#index"
  end
end
