class Response
  attr_reader :body

  def initialize(response)
    @body = JSON.parse(response)
  end
end