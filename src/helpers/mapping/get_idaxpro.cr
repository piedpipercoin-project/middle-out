module Helpers::Mapping::GetIdaxPro
  class Read
    JSON.mapping(
      code: {type: Int32, nilable: false},
      msg: {type: String, nilable: false},
      timestamp: {type: Int32},
      ticker: {type: Array(Ticker)}
    )

    class Ticker
      JSON.mapping(
        pair: {type: String},
        open: {type: String},
        high: {type: String},
        low: {type: String},
        last: {type: String},
        vol: {type: String}
      )
    end
  end
end