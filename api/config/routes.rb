# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "home#index"
  get "search", to: "searches#index"
  get "terms", to: "terms#index"
end
