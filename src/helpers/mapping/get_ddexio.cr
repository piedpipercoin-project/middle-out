module Helpers::Mapping::GetDdexIo
  class Read
    JSON.mapping(
      status: {type: Int32, nilable: false},
      desc: {type: String, nilable: false},
      data: {type: Data}
    )

    class Data
      JSON.mapping(
        ticker: {type: Ticker}
      )

      class Ticker
        JSON.mapping(
          marketId: {type: String},
          price: {type: String},
          volume: {type: String},
          bid: {type: String},
          ask: {type: String},
          low: {type: String},
          high: {type: String},
          updatedAt: {type: Int32}
        )
      end
    end
  end
end