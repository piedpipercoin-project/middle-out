class PingExchanges < Mosquito::PeriodicJob
  run_every 4.minute

  def perform
    log Time.utc

    getDdexIo
    log("------------------------------")
    getIdaxPro
    log("------------------------------")
    getSaturnNetwork
    log("------------------------------")
    getBambooRelay
    log("------------------------------")
  end

  def getBambooRelay
    log("getBambooRelay")
    url = "https://rest.bamboorelay.com/main/0x/markets/PPI-WETH/ticker"
    load = Helpers::Mapping::GetBambooRelay::Read.from_json(get(url).to_json)            

    if load
      log("pair:" + load.id)
      log("price:" + load.ticker.price)
      log("high:" + load.ticker.bestAsk)
      log("volume: n/a")
    end
  end

  def getSaturnNetwork
    log("getSaturnNetwork")
    url = "https://ticker.saturn.network/returnTicker.json"
    ticker = "ETH_0x5a3c9a1725aa82690ee0959c89abe96fd1b527ee"
    preLoad = get(url)

    if preLoad
      load = preLoad["ETH_0x5a3c9a1725aa82690ee0959c89abe96fd1b527ee"] 
      log("pair: #{load["symbol"]}")
      log("price: #{load["last"]}")
      log("high: #{load["highestBid"]}")
      log("volume: #{load["baseVolume"]}")
    end
  end

  def getIdaxPro
    log("getIdaxPro")
    url = "https://openapi.idax.pro/api/v2/ticker?pair=PPI_BTC"
    load = Helpers::Mapping::GetIdaxPro::Read.from_json(get(url).to_json)            

    if load && load.code == 10000
      load.ticker.each do |ticker|
        log("pair:" + ticker.pair)
        log("price:" + ticker.last)
        log("high:" + ticker.high)
        log("volume:" + ticker.vol)
      end
    end
  end

  def getCryptoBridge
    
  end

  def getDdexIo
    log("getDdexIo")
    url = "https://api.ddex.io/v3/markets/PPI-WETH/ticker"
    load = Helpers::Mapping::GetDdexIo::Read.from_json(get(url).to_json)            

    if load && load.status == 0
      log("pair:" + load.data.ticker.marketId)
      log("price:" + load.data.ticker.price)
      log("high:" + load.data.ticker.high)
      log("volume:" + load.data.ticker.volume)
    end
  end

  def get(url)
    getRequest = Crest.get(
      url,
      handle_errors: false,
      logging: false
    )

    if getRequest.status_code == 200
      response = JSON.parse(getRequest.body)
      return response
    end
  end
end