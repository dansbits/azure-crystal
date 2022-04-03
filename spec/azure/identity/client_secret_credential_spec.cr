require "uri/params"

require "../../spec_helper"
require "../../../src/azure-sdk/identity/client_secret_credential"

describe Azure::Identity::ClientSecretCredential do
  describe "#get_token" do
    it "gets a token with the given credentials" do
      client_id ="azure_sp_id"
      client_secret = "password"
      scope = "https://vault.azure.net/"
      tenant_id = "azure_tenant"
      request_body = URI::Params.encode({
        client_id: client_id,
        client_secret: client_secret,
        grant_type: "client_credentials",
        scope: scope
      })

      return_body = { 
        token_type: "Bearer",
        expires_in: 3900,
        ext_expires_in: 3900,
        access_token: "secret_token"
      }.to_json
      
      WebMock.stub(:get, "https://login.microsoftonline.com/#{tenant_id}/oauth2/v2.0/token")
        .with(body: request_body)
        .to_return(body: return_body)
      creds = Azure::Identity::ClientSecretCredential.new(client_id, client_secret, tenant_id)
      token = creds.get_token(scope)
      token.access_token.should eq "secret_token"
      token.token_type.should eq "Bearer"
      token.expires_in.should eq 3900
      token.ext_expires_in.should eq 3900
    end
  end
end
