class SpotifyDbusMock
  def [](_key)
    MetadataMock.new
  end
end

class MetadataMock
  def [](key)
    if key == 'xesam:title'
      return 'Tear In My Heart'
    elsif key == 'xesam:artist'
      return ['Twenty One Pilots']
    elsif key == 'xesam:album'
      return 'Blurryface'
    else
      raise "I don't know what to do with that key"
    end
  end
end
