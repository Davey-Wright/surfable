def day_forecast_stub
  day = Forecast::Mappers.day_struct.new
  day[:date] = t("2018-11-06")
  day[:tides] = tides
  day[:hours] = hours
  day[:first_light] = t('Tue, 06 Nov 2018 06:42:16 GMT +00:00')
  day[:sunrise] = t('Tue, 06 Nov 2018 07:17:56 GMT +00:00')
  day[:sunset] = t('Tue, 06 Nov 2018 16:38:53 GMT +00:00')
  day[:last_light] = t('Tue, 06 Nov 2018 17:14:33 GMT +00:00')
  day
end

def tides
  t1 = Forecast::Mappers.tide_struct.new
  t1[:type] = 'high'
  t1[:height] = 9.78
  t1[:time] = t('2018-11-06 05:06:50 +0000')

  t2 = Forecast::Mappers.tide_struct.new
  t2[:type] = 'low'
  t2[:height] = 1.32
  t2[:time] = t('2018-11-06 11:07:26 +0000')

  t3 = Forecast::Mappers.tide_struct.new
  t3[:type] = 'high'
  t3[:height] = 10.07
  t3[:time] = t('2018-11-06 17:26:03 +0000')

  t4 = Forecast::Mappers.tide_struct.new
  t4[:type] = 'low'
  t4[:height] = 1.11
  t4[:time] = t('2018-11-06 23:32:05 +0000')

  [t1, t2, t3, t4]
end

def hours
  hours = []
  x = 0
  while x <= 21
    hour = Forecast::Mappers.hour_struct.new
    hour[:value] = x
    hour[:swell] = swell
    hour[:wind] = wind
    hours.push hour
    x += 3
  end
  hours
end

def swell
  swell = Forecast::Mappers.swell_struct.new
  swell[:height] = 5
  swell[:period] = 12
  swell[:direction] = 73.34
  swell
end

def wind
  wind = Forecast::Mappers.wind_struct.new
  wind[:speed] = 7
  wind[:gusts] = 11
  wind[:average_speed] = 7
  wind[:direction] = 315
  wind
end

def t(str)
  Time.parse(str)
end
