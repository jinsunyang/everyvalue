require 'httpclient'
require 'active_support/concern'

module HttpClient
  extend ActiveSupport::Concern

  module ClassMethods
    def get(url, headers = nil)
      response = nil
      begin
        response = @http.get(url, header: headers)
      rescue HTTPClient::TimeoutError
        raise HTTPClient::TimeoutError.new("HTTP GET timed out. url=#{url}")
      end
      yield response if block_given?
      response
    end

    def head(url, headers = nil)
      response = @http.head(url, header: headers)
      yield response if block_given?
      response
    end

    def debug
      puts @http.proxy
    end

    def post(url, params = nil, headers = nil)
      response = nil

      begin
        response = @http.post(url, header: headers, body: params)
      rescue HTTPClient::TimeoutError
        raise HTTPClient::TimeoutError.new("HTTP POST timed out. url=#{url}, params=#{params}")
      end
      yield response if block_given?
      response
    end

    def post_json(url, json)
      response = nil

      begin
        response = @http.post(url, header: HTTPHeaders::JSON, body: json)
      rescue HTTPClient::TimeoutError
        raise HTTPClient::TimeoutError.new("HTTP POST/json timed out. url=#{url}, body=#{json}")
      end

      yield response if block_given?
      response
    end

    def delete(url, headers = nil)
      response = nil

      begin
        if headers.nil?
          response = @http.delete(url)
        else
          response = @http.delete(url, header: headers)
        end
      rescue HTTPClient::TimeoutError
        raise HTTPClient::TimeoutError.new("HTTP DELETE timed out. url=#{url}")
      end

      yield response if block_given?
      response
    end

    def put(url, params = nil, headers = nil)
      response = nil

      begin
        response = @http.put(url, header: headers, body: params)
      rescue HTTPClient::TimeoutError
        raise HTTPClient::TimeoutError.new("HTTP PUT timed out. url=#{url}, params=#{params}")
      end

      yield response if block_given?
      response
    end

    def put_json(url, json)
      response = nil

      begin
        response = @http.put(url, header: HTTPHeaders::JSON, body: json)
      rescue HTTPClient::TimeoutError
        raise HTTPClient::TimeoutError.new("HTTP PUT/json timed out. url=#{url}, body=#{json}")
      end

      yield response if block_given?
      response
    end

    def timeout(t)
      backup = @http.receive_timeout
      @http.receive_timeout = t
      yield
      @http.receive_timeout = backup
    end
  end
end

class HttpPersistent
  include HttpClient

  @http = HTTPClient.new
  @http.connect_timeout = 3
  @http.receive_timeout = 6
  @http.ssl_config.set_default_paths
end

class ConfigHttpPersistent
  include HttpClient

  @http = HTTPClient.new

  def self.config(params = {})
    @http.connect_timeout = params[:connect_timeout] || 2
    @http.receive_timeout = params[:receive_timeout] || 3
    @http.ssl_config.set_default_paths
    self
  end
end

module HTTPHeaders
  JSON = {'Content-Type' => 'application/json'}
end

module HTTP
  class Message
    def success?
      self.status == 200
    end

    def missing?
      self.status == 404
    end
  end
end
