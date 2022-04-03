require "http/client"
require "uri/params"
require "json"

require "./token"

module Azure
  module Identity
    class ClientSecretCredential
      property tenant_id : String
      property client_id : String
      property client_secret : String

      def initialize(client_id : String, client_secret : String, tenant_id : String)
        @client_id = client_id
        @client_secret = client_secret
        @tenant_id = tenant_id
      end

      def get_token(scope : String) : Token
        url = "https://login.microsoftonline.com/#{self.tenant_id}/oauth2/v2.0/token"

        params = {
          client_id: self.client_id,
          client_secret: self.client_secret,
          grant_type: "client_credentials",
          scope: scope
        }
        response = HTTP::Client.get url, form: URI::Params.encode(params)

        Token.from_json(response.body)
      end
    end
  end
end