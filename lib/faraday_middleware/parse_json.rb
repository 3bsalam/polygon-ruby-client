# frozen_string_literal: true

require 'faraday'
require 'json'

module FaradayMiddleware
  class ParseJson < Faraday::Response::Middleware
    def on_complete(env)
      env[:body] = JSON.parse(env[:body], symbolize_names: true) unless env[:body].strip.empty?
    end
  end
end

Faraday::Response.register_middleware parse_json: FaradayMiddleware::ParseJson
