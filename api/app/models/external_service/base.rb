# frozen_string_literal: true

module ExternalService
  # NOTE: 共通項を切り出す
  class Base
    SEARCH_TRACKS_NUMBER = 10
    DEFAULT_OFFSET_NUMBER = 0

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
