# frozen_string_literal: true

require 'faraday'
if RUBY_PLATFORM == 'java'
  require 'json'
  require_relative 'faraday_middleware/parse_json'
else
  require 'oj'
  require_relative 'faraday_middleware/parse_oj'
end

require 'faraday_middleware'
require 'faraday_middleware/response_middleware'
require_relative 'polygon/version'
require_relative 'polygon/logger'
require_relative 'polygon/api'
require_relative 'polygon/api/client' # Ensure this line is included to require the client
