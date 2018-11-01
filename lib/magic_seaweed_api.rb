class MagicSeaweedAPI
  attr_reader :response

  def initialize
    @response = request
    @forecast_days = []
  end

  def request
    url = "http://magicseaweed.com/api/#{ENV['MSW_KEY']}/forecast/?spot_id=1449"
    res = HTTParty.get(url)
    res.code != 200 ? error(res) : res
  end

  def error(res)
    { code: res.code, message: res.message }
  end

  private

  def forecast
    binding.pry
    dates = response.map { |res| get_date(res) }

    shaka = response.each do |res|
      Array.new { dates.uniq.each { |date| date == get_date(res) } }
    end
  end

  def get_date(data)
    Time.at(data['localTimestamp']).day
  end

end
