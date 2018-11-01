class SunriseSunsetAPI
  attr_reader :response

  def initialize
    @response = request
  end

  def request
    Array.new(4) do |n|
      url = "https://api.sunrise-sunset.org/json?lat=51.48&lng=-3.69&formatted=0&date=#{date(n)}"
      res = HTTParty.get(url)
      res.code != 200 ? error(res) : res
    end
  end

  def error(res)
    { code: res.code, message: res.message }
  end

  private

  def date(num)
    (Time.now + num.day).strftime('%F')
  end

end
