# frozen_string_literal: true

module ExternalService
  class Response
    attr_reader :body

    def initialize(response)
      @body = JSON.parse(response)
    end
  end
end
