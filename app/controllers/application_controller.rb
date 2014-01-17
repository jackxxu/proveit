class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
    def get_json(path)
      JSON.parse access_token.get(desk_url(path)).body
    end

    def post_json(path, new_hash)
      response = access_token.post(
        desk_url(path),
        new_hash.to_json,
        {'Accept' => 'application/json', 'Content-Type' => 'application/json'})
      if (response.code == '201')
        JSON.parse response.body
      else
        raise response.message
      end
    end

    def put_json(path, update_params)
      response = access_token.put(
        desk_url(path),
        update_params.to_json,
        {'Accept' => 'application/json', 'Content-Type' => 'application/json'})
      if (response.code == '200')
        JSON.parse response.body
      else
        raise response.message
      end
    end

    def desk_url(path)
      full_path = path.starts_with?('/api') ? path : "/api/v2/#{path}"
      "https://#{ENV['DESK_SUBDOMAIN']}.desk.com#{full_path}"
    end

    def access_token
      @access_token ||= create_access_token
    end

    def create_access_token
      consumer = OAuth::Consumer.new(
              ENV['CONSUMER_KEY'],
              ENV['CONSUMER_SECRET'],
              :site => "https://#{ENV['DESK_SUBDOMAIN']}.desk.com",
              :scheme => :header
      )

      OAuth::AccessToken.from_hash(
              consumer,
              :oauth_token => ENV['OAUTH_TOKEN'],
              :oauth_token_secret => ENV['OAUTH_TOKEN_SECRET']
      )
    end

end
