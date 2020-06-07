# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "searches#index"
  resource "searches", only: %i(index show)
end
