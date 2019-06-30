class PingIdax < Mosquito::PeriodicJob
  run_every 4.minute

  def perform
    log Time.utc

    log("getIdaxPro")
    url = "https://openapi.idax.pro/api/v2/ticker?pair=PPI_BTC"
    load = Helpers::Mapping::GetIdaxPro::Read.from_json(get(url).to_json)
    mName = "IDAX"

    if load && load.code == 10000
      load.ticker.each do |ticker|
        RC.multi do |multi|
          multi.set("market:#{mName}:price", ticker.last)
          multi.set("market:#{mName}:pair", ticker.pair.gsub("_", "-"))
          multi.set("market:#{mName}:volume", ticker.vol)
        end
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