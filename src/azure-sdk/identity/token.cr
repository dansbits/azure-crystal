module Azure
  module Identity
    struct Token
      include JSON::Serializable
      
      property token_type : String
      property expires_in : Int32
      property ext_expires_in : Int32
      property access_token : String
    end
  end
end