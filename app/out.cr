require "onyx/http"
require "onyx/env"
require "onyx/logger"
require "crest"

require "../src/endpoints/**"
require "../src/views/**"

# routes
Onyx::HTTP.get "/health", Endpoints::Health::Status

Onyx::HTTP.get "/exchanges", Endpoints::Exchanges::All

Onyx::HTTP.listen("0.0.0.0", ENV["PORT"].to_i)