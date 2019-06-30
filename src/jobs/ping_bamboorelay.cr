class PingDdex < Mosquito::PeriodicJob
  run_every 4.minute

  def perform
    log Time.utc

    log("getBambooRelay")
    url = "https://rest.bamboorelay.com/main/0x/markets/PPI-WETH/ticker"
    load = Helpers::Mapping::GetBambooRelay::Read.from_json(get(url).to_json)            

    if load
      log("pair:" + load.id)
      log("price:" + load.ticker.price)
      log("high:" + load.ticker.bestAsk)
      log("volume: n/a")
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