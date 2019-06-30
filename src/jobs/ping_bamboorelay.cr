class PingBambooRelay < Mosquito::PeriodicJob
  run_every 4.minute

  def perform
    log Time.utc

    log("getBambooRelay")
    url = "https://rest.bamboorelay.com/main/0x/markets/PPI-WETH/ticker"
    load = Helpers::Mapping::GetBambooRelay::Read.from_json(get(url).to_json)            
    mName = "BAMBOORELAY"

    if load
      RC.multi do |multi|
        multi.set("market:#{mName}:price", load.ticker.price)
        multi.set("market:#{mName}:pair", load.id)
        multi.set("market:#{mName}:volume", "")
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