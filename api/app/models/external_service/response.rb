# frozen_string_literal: true

module ExternalService
  class Response
    attr_reader :status_code, :body

    # NOTE: 今後このモデルが成長してきたら、テストが必要
    def initialize(status_code:, body:)
      @status_code = status_code.to_i
      # NOTE: AppleMusic で Authorization エラーが発生する場合は、response_body が空文字になり、JSON.parse できないため
      #   以下で JSON.parse できる形にしている。ここで raise させるのではなく、ExternalService::AppleMusic などで raise するための処置。
      @body = JSON.parse(body) unless body == ""
    end
  end
end
