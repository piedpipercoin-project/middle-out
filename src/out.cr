require "onyx/http"
require "onyx/env"
require "onyx/logger"
require "redis"
require "crest"

RC = Redis::PooledClient.new(url: ENV["REDIS_URL"])

require "./endpoints/**"
require "./views/**"

# routes
Onyx::HTTP.get "/health", Endpoints::Health::Status

Onyx::HTTP.get "/exchanges", Endpoints::Exchanges::All

Onyx::HTTP.listen(
  host: ENV["HOST"]? || "0.0.0.0", 
  port: ENV["PORT"]?.try(&.to_i) || 5000
)