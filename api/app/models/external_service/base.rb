# frozen_string_literal: true

module ExternalService
  class Base
    # NOTE: AppleMusic が一回のリクエストで取得できる曲数が25までだったため、その数字に合わせている。
    SEARCH_TRACKS_NUMBER = 25
    DEFAULT_OFFSET_NUMBER = 0
    OK_STATUS_CODE = 200

    def self.search(keyword:, offset: DEFAULT_OFFSET_NUMBER)
      new(keyword: keyword, offset: offset).search
    end

    def initialize(keyword:, offset: DEFAULT_OFFSET_NUMBER)
      @keyword = keyword
      @offset = offset
    end

    private
      attr_reader :keyword, :offset
  end
end
