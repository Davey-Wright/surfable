class AdmiraltyAPI
  attr_reader :response

  def initialize
    @response = request
  end

  def request
    url = 'https://admiraltyapi.azure-api.net/uktidalapi/api/V1/Stations/0512/TidalEvents?duration=4'
    headers = { 'Ocp-Apim-Subscription-Key': ENV['ADMIRALTY_PRIMARY_KEY'] }
    res = HTTParty.get(url, headers: headers)
    res.code != 200 ? error(res) : res
  end

  def error(res)
    { code: res.code, message: res.message }
  end

end
