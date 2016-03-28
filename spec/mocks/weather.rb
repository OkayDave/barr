class WeatherMock
  def condition
    WeatherConditionMock.new
  end
end

class WeatherConditionMock
  def temp
    100
  end

  def text
    'Nice day'
  end
end
