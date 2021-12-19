# frozen_string_literal: true

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins %w[https://sound-links.com http://localhost:8080]
    resource '*', headers: :any, methods: %i[get options head]
  end
end
