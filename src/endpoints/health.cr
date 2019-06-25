struct Endpoints::Health::Status
  include Onyx::HTTP::Endpoint
  include Base

  def call
    status(200)

    @payload["status"] = "ok"

    return Views::Payload.new(@payload)
  end
end