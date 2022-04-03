require "../identity/client_secret_credential"
require "http/client"

module Azure
  class SecretClient

    property vault_url : String
    property credential : Identity::CLientSecretCredential

    def initialize(vault_url : String, credential : CLientSecretCredential)
      @vault_url = vault_url
      @credential = credential
    end

    def get_secret(secret_name)
      url = "#{vault_url}/secrets/#{secret_name}?api-version=7.2"
      token = @credential.get_token("https://vault.azure.net/.default")
      response = HTTP::Client.get(url, headers: HTTP::Headers{"Authorization" => "Bearer #{token["access_token"].to_s}"})
      JSON.parse(response.body)
    end
  end
end