struct Views::Payload
  include Onyx::HTTP::View

  def initialize(@data : 
      Hash(String, String)
    )
  end

  json({
    "data": @data
  })
end