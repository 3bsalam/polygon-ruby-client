module Polygon
  module Api
    class Client
      include Endpoints
      include Connection
      include Request
      include Config

      def initialize(options = {})
        Config::ATTRIBUTES.each do |key|
          send("#{key}=", options[key]) || Polygon::Api.config.send(key)
        end
      end
      private

      def endpoint
        "https://api.polygon.io" # Replace this with your actual API endpoint
      end
    end
  end
end
