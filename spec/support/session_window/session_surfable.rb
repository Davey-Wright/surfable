def session_surfable
  forecast = Windfinder::Forecast.new('https://www.windfinder.com/forecast/rest_bay', 'long_term').shaka
  binding.pry

  day = forecast.days.first

  hour1 = day.hours[0]
  hour1.swell.direction = 261
  hour1.swell.height = 1.5
  hour1.swell.period = 12

  hour1.wind.direction = 90
  hour1.wind.speed = 12
  hour1.wind.gusts = 21

  hour1.tide.height = 3.1
  hour1.tide.time = nil
  hour1.tide.type = 'up'


  hour2 = day.hours[1]
  hour2.swell.direction = 261
  hour2.swell.height = 1.5
  hour2.swell.period = 12

  hour2.wind.direction = 90
  hour2.wind.speed = 12
  hour2.wind.gusts = 21

  hour2.tide.height = 7.2
  hour2.tide.time = nil
  hour2.tide.type = 'up'


  hour3 = day.hours[2]
  hour3.swell.direction = 261
  hour3.swell.height = 1.5
  hour3.swell.period = 12

  hour3.wind.direction = 90
  hour3.wind.speed = 12
  hour3.wind.gusts = 19

  hour3.tide.height = 7.2
  hour3.tide.time = '5:43'
  hour3.tide.type = 'high'


  hour4 = day.hours[3]
  hour4.swell.direction = 270
  hour4.swell.height = 1.5
  hour4.swell.period = 12

  hour4.wind.direction = 90
  hour4.wind.speed = 11
  hour4.wind.gusts = 16

  hour4.tide.height = 3.4
  hour4.tide.time = nil
  hour4.tide.type = 'down'


  hour5 = day.hours[4]
  hour5.swell.direction = 270
  hour5.swell.height = 1.5
  hour5.swell.period = 12

  hour5.wind.direction = 90
  hour5.wind.speed = 7
  hour5.wind.gusts = 10

  hour5.tide.height = 2.2
  hour5.tide.time = '11:47'
  hour5.tide.type = 'low'


  hour6 = day.hours[5]
  hour6.swell.direction = 270
  hour6.swell.height = 1.5
  hour6.swell.period = 12

  hour6.wind.direction = 90
  hour6.wind.speed = 7
  hour6.wind.gusts = 9

  hour6.tide.height = 7.1
  hour6.tide.time = nil
  hour6.tide.type = 'up'


  hour7 = day.hours[6]
  hour7.swell.direction = 270
  hour7.swell.height = 1.5
  hour7.swell.period = 12

  hour7.wind.direction = 90
  hour7.wind.speed = 7
  hour7.wind.gusts = 9

  hour7.tide.height = 8.3
  hour7.tide.time = '18:00'
  hour7.tide.type = 'high'


  hour8 = day.hours[7]
  hour8.swell.direction = 270
  hour8.swell.height = 1.5
  hour8.swell.period = 12

  hour8.wind.direction = 90
  hour8.wind.speed = 7
  hour8.wind.gusts = 9

  hour8.tide.height = 3.6
  hour8.tide.time = nil
  hour8.tide.type = 'down'

  day.high_tide = day.set_tide('high')
  day.low_tide = day.set_tide('low')
  return day

end
