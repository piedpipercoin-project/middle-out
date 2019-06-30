class PingDdex < Mosquito::PeriodicJob
  run_every 4.minute

  def perform
    log Time.utc

    log("getDdexIo")
    url = "https://api.ddex.io/v3/markets/PPI-WETH/ticker"
    load = Helpers::Mapping::GetDdexIo::Read.from_json(get(url).to_json)            
    mName = "DDEX"

    if load && load.status == 0
      RC.multi do |multi|
        multi.set("market:#{mName}:price", load.data.ticker.price)
        multi.set("market:#{mName}:pair", load.data.ticker.marketId)
        multi.set("market:#{mName}:volume", load.data.ticker.volume)
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