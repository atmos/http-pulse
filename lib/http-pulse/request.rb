module HttpPulse
  class RequestError < StandardError; end
  class Monitor
    def initialize(token, environment = :production)
      raise RequestError, "Token not configured" if token.nil? || token.empty?
      @token, @environment = token, environment
    end

    def get
      response = RestClient.get(endpoint, {:accept => :json})
      handle_response(response)
    end

    def create(url)
      response = RestClient.post(endpoint, {:url => url}, {:content_type => :json, :accept => :json})
      handle_response(response)
    end

    def delete(url)
      if object_id = id_for_url(url)
        response = RestClient.delete("#{endpoint}/#{object_id}")
        JSON.parse(response) == { }
      else
        false
      end
    end

    private

    def id_for_url(url)
      monitors = get
      monitors.each do |monitor|
        return monitor['_id'] if monitor['url'] == url
      end
      nil
    end

    def handle_response(response)
      raise RequestError, response.inspect unless (200...299).include?(response.code)
      JSON.parse(response.to_s)
    end

    def endpoint
      "#{endpoint_host}/v1/#{@token}/monitors"
    end

    def endpoint_host
      endpoints = {
        :dev        => 'http://localhost:9393',
        :production => 'http://http-pulse.heroku.com'
      }
      endpoints[@environment.to_sym] || raise(ArgumentError, "Unknown Environment #{@environment}")
    end
  end
end
