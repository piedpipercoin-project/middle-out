module Helpers::Mapping::GetBambooRelay
  class Read
    JSON.mapping(
      id: {type: String, nilable: false},
      ticker: {type: Ticker}
    )

    class Ticker
      JSON.mapping(
        transactionHash: {type: String},
        price: {type: String},
        size: {type: String},
        timestamp: {type: Int32},
        bestBid: {type: String},
        bestAsk: {type: String},
        spreadPercentage: {type: String}
      )
    end
  end
end