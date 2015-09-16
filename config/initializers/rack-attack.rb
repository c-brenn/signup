class Rack::Attack
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

#  Rack::Attack.blacklist('ban login scrapers') do |req|
#    # block clients making a lot of requests for access tokens/login for 1 hour
#    Rack::Attack::Allow2Ban.filter(req.ip, :maxretry => 20, :findtime => 1.minute, :bantime => 1.hour) do
#      req.path == '/api/access' || req.path == '/users/sign_in'
#    end
#  end
#
#  # throttle requests to import to 2 per second per ip
#  Rack::Attack.throttle('req/ip', :limit => 2, :period => 1.second) do |req|
#    req.ip if req.path == '/api/members/import'
#  end
end
