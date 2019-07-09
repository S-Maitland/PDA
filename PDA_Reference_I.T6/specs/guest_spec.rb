require('minitest/autorun')
require('minitest/rg')
require_relative('../guest.rb')

class GuestTest < MiniTest::Test

  def setup()
    @guest = Guest.new("Travis", 100, "Thunderstruck")
  end

  def test_guest_name
    assert_equal("Travis", @guest.name)
  end

  def test_guest_wallet_total
    assert_equal(100, @guest.wallet)
  end

  def test_guest_favourite_song
    assert_equal("Thunderstruck", @guest.favourite_song)
  end

end
