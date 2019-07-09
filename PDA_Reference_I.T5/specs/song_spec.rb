require('minitest/autorun')
require('minitest/rg')
require_relative('../song.rb')

class SongTest < MiniTest::Test

  def setup()
    @song1 = Song.new("Thunderstruck", "AC/DC", 1990)
  end

  def test_song_name
    assert_equal("Thunderstruck", @song1.name)
  end
  def test_song_artist
    assert_equal("AC/DC", @song1.artist)
  end
  def test_song_release_year
    assert_equal(1990, @song1.release_year)
  end

end
