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
        {
        }
      end

      def request_phase
        redirect callback_url
      end

      def callback_phase
        # would be nice if you could pass a yield to this and handle it that way
        #options.func[self, request]

        lcghd = request.cookies['__lcghd']

        if lcghd.nil? # cookie doesn't exist, lets redirect to site to login
          uri = URI(api_uri)
          uri.query = URI.encode_www_form({ callback_param => callback_url }) unless callback_param.nil?
          redirect uri.to_s
        else
          json = %x(/bin/echo -n "#{lcghd}" | perl lib/decode.pl)
          if json.present?
            user = JSON.parse(json)
            @id = user['userid']
            super
          else
            # couldn't read cookie, something is up, redirect to the employee site.
            uri = URI(api_uri)
            uri.query = URI.encode_www_form({ callback_param => callback_url }) unless callback_param.nil?
            redirect uri.to_s
          end
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
