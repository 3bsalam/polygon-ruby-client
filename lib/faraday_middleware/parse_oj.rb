# frozen_string_literal: true

require 'faraday'
require 'oj'

module FaradayMiddleware
  class ParseOj < Faraday::Response::Middleware
    def on_complete(env)
      env[:body] = Oj.load(env[:body], mode: :compat, symbol_keys: true) unless env[:body].strip.empty?
    end
  end
end

Faraday::Response.register_middleware parse_oj: FaradayMiddleware::ParseOj
