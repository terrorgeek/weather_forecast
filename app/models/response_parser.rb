class ResponseParser
  class << self
    def parse(response)
      return response if response.is_a?(Hash)
      response = JSON.parse(response).deep_symbolize_keys
      response[:days].first
    end
  end
end