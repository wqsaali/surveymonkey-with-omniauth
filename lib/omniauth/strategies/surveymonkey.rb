require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class Surveymonkey < OmniAuth::Strategies::OAuth2
      DEFAULT_RESPONSE_TYPE = 'code'
      DEFAULT_GRANT = 'authorization_code'
      option :name, "surveymonkey"

      option :client_options, {
        :site => "https://api.surveymonkey.net",
        :authorize_url => '/oauth/authorize',
        :token_url => '/oauth/token'
      }

      option :authorize_options, [:api_key, :client_id]

      def authorize_params
        super.tap do |params|
          params[:response_type] ||= DEFAULT_RESPONSE_TYPE
          params[:client_id] = options[:client_id]
          params[:api_key] = options[:api_key]
        end
      end
      
      def build_access_token
        verifier = request.params['code']
        token = client.auth_code.get_token(verifier, token_params)
      end

      def callback_phase
        options[:client_options][:token_url] = "/oauth/token?api_key=#{options[:api_key]}"
        self.access_token = build_access_token
        self.env['omniauth.auth'] = auth_hash
        call_app!
      end

      def token_params
        super.tap do |params|
          params[:grant_type] ||= DEFAULT_GRANT
          params[:client_id] = options[:client_id]
          params[:client_secret] = options[:client_secret]
          params[:redirect_uri] = callback_url
        end
      end

      def callback_url
        full_host + script_name + callback_path# + query_string
      end

      def full_host
        case OmniAuth.config.full_host
        when String
          OmniAuth.config.full_host
        when Proc
          OmniAuth.config.full_host.call(env)
        else
          # in Rack 1.3.x, request.url explodes if scheme is nil
          if request.scheme && request.url.match(URI::ABS_URI)
            uri = URI.parse(request.url.gsub(/\?.*$/, ''))
            uri.path = ''
            # sometimes the url is actually showing http inside rails because the
            # other layers (like nginx) have handled the ssl termination.
            uri.scheme = 'https' if ssl? # rubocop:disable BlockNesting
            uri.to_s
          else ''
          end
        end
      end
      def script_name
        @env['SCRIPT_NAME'] || ''
      end
      def callback_path
        @callback_path ||= begin
          path = options[:callback_path] if options[:callback_path].is_a?(String)
          path ||= current_path if options[:callback_path].respond_to?(:call) && options[:callback_path].call(env)
          path ||= custom_path(:request_path)
          path ||= "#{path_prefix}/#{name}/callback"
          path
        end
      end
      def query_string
        request.query_string.empty? ? '' : "?#{request.query_string}"
      end
    end
  end
end
