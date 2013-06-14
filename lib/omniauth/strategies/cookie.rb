module OmniAuth
  module Strategies
    class Cookie
      include OmniAuth::Strategy

      args [:endpoint, :callback_param]

      option :fields, [:id]

      uid do
        @id
      end

      info do
      end

      def request_phase
        redirect callback_url
      end

      def callback_phase
        token = request.cookies['token']

        if token.nil?
          uri = URI(api_uri)
          uri.query = URI.encode_www_form({ callback_param => callback_url }) unless callback_param.nil?
          redirect uri.to_s
        else
          id = CGI::unescape(token)
          @id = Base64.decode64(id)
          super
        end
      end

    protected

      def api_uri
        options.endpoint
      end

      def callback_param
        options.callback_param
      end

    end
  end
end
