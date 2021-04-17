# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "home#index"
  get "search", to: "search#index"
  get "terms", to: "terms#index"
end
