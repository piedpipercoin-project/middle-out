struct Endpoints::Exchanges::All
  include Onyx::HTTP::Endpoint
  
  @payload = Hash(String, Array(NamedTuple(market: String, price: String, pair: String, logo: String))).new

  def call
    @payload["exchanges"] = [] of NamedTuple(market: String, price: String, pair: String, logo: String)

    # ddex data
    priceDdex = Redis::Future.new
    pairDdex = Redis::Future.new
    RC.multi do |multi|
      priceDdex = multi.get("market:DDEX:price")
      pairDdex = multi.get("market:DDEX:pair")
    end

    @payload["exchanges"] << {
      market: "DDEX",
      price: priceDdex.try(&.value).to_s,
      pair: pairDdex.try(&.value).to_s,
      logo: "https://raw.githubusercontent.com/piedpipercoin-project/website/master/src/assets/markets/ddex.png"
    }

    # idax data
    priceIdax = Redis::Future.new
    pairIdax = Redis::Future.new
    RC.multi do |multi|
      priceIdax = multi.get("market:IDAX:price")
      pairIdax = multi.get("market:IDAX:pair")
    end

    @payload["exchanges"] << {
      market: "IDAX",
      price: priceIdax.try(&.value).to_s,
      pair: pairIdax.try(&.value).to_s,
      logo: "https://raw.githubusercontent.com/piedpipercoin-project/website/master/src/assets/markets/idax.png"
    }

     # saturnnetwork data
     priceSn = Redis::Future.new
     pairSn = Redis::Future.new
     RC.multi do |multi|
       priceSn = multi.get("market:SATURNNETWORK:price")
       pairSn = multi.get("market:SATURNNETWORK:pair")
     end
 
     @payload["exchanges"] << {
       market: "SATURNNETWORK",
       price: priceSn.try(&.value).to_s,
       pair: pairSn.try(&.value).to_s,
       logo: "https://raw.githubusercontent.com/piedpipercoin-project/website/master/src/assets/markets/saturnnetwork.png"
     }

     # bamboorelay data
     priceBr = Redis::Future.new
     pairBr = Redis::Future.new
     RC.multi do |multi|
       priceBr = multi.get("market:BAMBOORELAY:price")
       pairBr = multi.get("market:BAMBOORELAY:pair")
     end
 
     @payload["exchanges"] << {
       market: "BAMBOORELAY",
       price: priceBr.try(&.value).to_s,
       pair: pairBr.try(&.value).to_s,
       logo: "https://raw.githubusercontent.com/piedpipercoin-project/website/master/src/assets/markets/bamboorelay.png"
     }

     # forkdelta data
     @payload["exchanges"] << {
      market: "FORKDELTA",
      price: "",
      pair: "PPI-ETH",
      logo: "https://raw.githubusercontent.com/piedpipercoin-project/website/master/src/assets/markets/forkdelta.png"
    }

    # cryptobridge data
    @payload["exchanges"] << {
      market: "CRYPTOBRIDGE",
      price: "",
      pair: "PPI-BTC",
      logo: "https://raw.githubusercontent.com/piedpipercoin-project/website/master/src/assets/markets/cryptobridge.png"
    }

    status(200)
    return Views::Payload.new(@payload)
  end
end