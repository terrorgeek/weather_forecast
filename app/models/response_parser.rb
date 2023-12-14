class ResponseParser
  class << self
    def parse(response)
      return response if response.is_a?(Hash)
      
      # We can also do other error handling here other than JSON::ParserError
      begin
        response_base_structure(result: :success, data: JSON.parse(response))
      rescue JSON::ParserError => e
        response_base_structure(result: :failed, data: nil, msg: e.message)
      rescue TypeError => e
        response_base_structure(result: :failed, data: nil, msg: e.message)
      end
    end

    def response_base_structure(result:, data: nil, msg: nil)
      { result: result, data: data, msg: msg }
    end
  end
end