module B2
  class Base
    include HTTParty
    attr_accessor :download_url

    [:get, :head, :post, :put].each do |req|
      define_method(req) do |path, options={}, &block|
        self.class.send(req, path, options, &block)
      end
    end

    def initialize
      B2::Authentication.authorize if B2::Base.base_uri.nil? || (B2::Base.cookies[:expired] < Time.now)
      @download_url = B2::Base.cookies[:download_url]
    end

  end
end