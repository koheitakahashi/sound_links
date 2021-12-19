# frozen_string_literal: true

Rails.application.routes.draw do
  namespace 'api', { format: 'json' } do
    namespace 'v1' do
      get 'search', to: 'searches#index'
      get 'health', to: 'healths#index'
    end
  end
end
