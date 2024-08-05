module Polygon
  module Api
    module Connection
      private

      def headers
        {}
      end

      def connection
        @connection ||= begin
          options = {}

          options[:headers] = {}
          options[:headers]['Accept'] = 'application/json; charset=utf-8'
          options[:headers]['Content-Type'] = 'application/json; charset=utf-8'
          options[:headers]['User-Agent'] = user_agent if user_agent
          options[:proxy] = proxy if proxy
          options[:ssl] = { ca_path: ca_path, ca_file: ca_file } if ca_path || ca_file

          request_options = {}
          request_options[:timeout] = timeout if timeout
          request_options[:open_timeout] = open_timeout if open_timeout
          request_options[:params_encoder] = Faraday::FlatParamsEncoder
          options[:request] = request_options if request_options.any?
          connection = ::Faraday::Connection.new(endpoint, options) do |conn|
            conn.use Faraday::Response::RaiseError
            if RUBY_PLATFORM == 'java'
              conn.use FaradayMiddleware::ParseJson, content_type: /\bjson$/
            else
              conn.use FaradayMiddleware::ParseOj, content_type: /\bjson$/
            end
            conn.response :logger, logger if logger
            conn.adapter ::Faraday.default_adapter
          end

          puts "Connection initialized: #{connection.inspect}" # Debugging line to inspect the connection object
          connection
        end
      end
    end
  end
end
