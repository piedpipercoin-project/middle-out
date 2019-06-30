require "onyx/http"
require "onyx/env"
require "onyx/logger"
require "crest"

require "./endpoints/**"
require "./views/**"

# routes
Onyx::HTTP.get "/health", Endpoints::Health::Status

Onyx::HTTP.get "/exchanges", Endpoints::Exchanges::All

Onyx::HTTP.listen("0.0.0.0", ENV["ONYX_PORT"].to_i)