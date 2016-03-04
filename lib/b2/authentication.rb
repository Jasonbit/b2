module B2::Authentication

  class << self
    def authorize
      options = {
        basic_auth: {username: B2.account_id, password: B2.application_key}
      }

      response = HTTParty.get("#{BASE_URI}b2_authorize_account", options)

      B2::Base.base_uri "#{response['apiUrl']}/b2api/v1/"
      B2::Base.headers 'Authorization' => response['authorizationToken'], 'Content-Type' => 'application/json'
      B2::Base.cookies.merge!(download_url: response['downloadUrl'])
    end
  end
end