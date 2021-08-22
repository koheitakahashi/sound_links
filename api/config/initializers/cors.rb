# frozen_string_literal: true

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins %w[http://sound-links.com localhost:8080]
    resource "*", headers: :any, methods: %i[get options head]
  end
end
