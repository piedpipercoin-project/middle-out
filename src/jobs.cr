require "mosquito"
require "crest"
require "json"
require "redis"

RC = Redis::PooledClient.new(url: ENV["REDIS_OUT_URL"])

require "./helpers/**"
require "./jobs/**"

Mosquito::Runner.start