# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "search#index"

  get "results", to: "results#index"
end
