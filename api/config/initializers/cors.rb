Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # TODO: production の設定も追加
    origins "localhost:8080"
    resource "/api/v1/search", headers: :any, methods: [:get]
  end
end
