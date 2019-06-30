class PingDdex < Mosquito::PeriodicJob
  run_every 4.minute

  def perform
    log Time.utc

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
    log("------------------------------")
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