class Rack::Attack
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

  Rack::Attack.blacklist('ban login scrapers') do |req|
    # block clients making a lot of requests for access tokens for 1 hour
    Rack::Attack::Allow2Ban.filter(req.ip, :maxretry => 10, :findtime => 1.minute, :bantime => 1.hour) do
      req.path == '/api/access'
    end
  end

  # throttle requests to import to 2 per second per ip
  Rack::Attack.throttle('req/ip', :limit => 2, :period => 1.second) do |req|
    req.ip if req.path == '/api/members/import'
  end
end
