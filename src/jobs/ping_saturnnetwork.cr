class PingSaturnNetwork < Mosquito::PeriodicJob
  run_every 4.minute

  def perform
    log Time.utc

    log("getSaturnNetwork")
    url = "https://ticker.saturn.network/returnTicker.json"
    ticker = "ETH_0x5a3c9a1725aa82690ee0959c89abe96fd1b527ee"
    preLoad = get(url)
    mName = "SATURNNETWORK"

    if preLoad
      load = preLoad["ETH_0x5a3c9a1725aa82690ee0959c89abe96fd1b527ee"] 

      RC.multi do |multi|
        multi.set("market:#{mName}:price", load["last"])
        multi.set("market:#{mName}:pair", "#{load["symbol"]}-ETH")
        multi.set("market:#{mName}:volume", load["baseVolume"])
      end
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