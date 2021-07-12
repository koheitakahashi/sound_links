# frozen_string_literal: true

Rails.application.routes.draw do
  namespace "api" do
    namespace "v1" do
      get "search", to: "searches#index"
    end
  end
end
