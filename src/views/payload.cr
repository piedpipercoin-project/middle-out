struct Views::Payload
  include Onyx::HTTP::View

  def initialize(@data : 
      Hash(String, String) |
      Hash(String, Array(NamedTuple(market: String, price: String, pair: String, logo: String, link: String)))
    )
  end

  json({
    "data": @data
  })
end