# frozen_string_literal: true

module ExternalService
  class Response
    attr_reader :body

    # NOTE: 今後このモデルが成長してきたら、テストが必要
    def initialize(response)
      @body = JSON.parse(response)
    end
  end
end
