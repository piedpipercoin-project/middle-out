struct Endpoints::Exchanges::All
  include Onyx::HTTP::Endpoint
  
  @payload = Hash(String, Array(NamedTuple(market: String, price: String, pair: String, logo: String, link: String))).new

  def call
    @payload["exchanges"] = [] of NamedTuple(market: String, price: String, pair: String, logo: String, link: String)

    # forkdelta data
    @payload["exchanges"] << {
      market: "FORKDELTA",
      price: "",
      pair: "PPI-ETH",
      link: "https://forkdelta.app/#!/trade/0x5a3c9a1725aa82690ee0959c89abe96fd1b527ee-ETH",
      logo: "https://raw.githubusercontent.com/piedpipercoin-project/website/master/src/assets/markets/forkdelta.png"
    }

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
      link: "https://ddex.io/trade/PPI-WETH",
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
      link: "https://www.idax.pro/exchange?pairname=PPI_BTC",
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
      link: "https://www.saturn.network/exchange/ETH/order-book/0x5a3c9a1725aa82690ee0959c89abe96fd1b527ee/0x0000000000000000000000000000000000000000",
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
      link: "https://bamboorelay.com/trade/PPI-WETH",
      logo: "https://raw.githubusercontent.com/piedpipercoin-project/website/master/src/assets/markets/bamboorelay.png"
    }

    # cryptobridge data
    @payload["exchanges"] << {
      market: "CRYPTOBRIDGE",
      price: "",
      pair: "PPI-BTC",
      link: "https://wallet.crypto-bridge.org/market/BRIDGE.PPI_BRIDGE.BTC",
      logo: "https://raw.githubusercontent.com/piedpipercoin-project/website/master/src/assets/markets/cryptobridge.png"
    }

    status(200)
    return Views::Payload.new(@payload)
  end
end