require('minitest/autorun')
require('minitest/rg')
require_relative('../room.rb')
require_relative('../song.rb')
require_relative('../guest.rb')
require_relative('../bar_tab.rb')

class RoomTest < MiniTest::Test

  def setup()
    #create room object to be used in testing
    @room1 = Room.new("Angus", 6, 30)
    @bar_tab = Bar_Tab.new()

    #create guest objects and assign them to global variables
    @guest1 = Guest.new("Navid", 100, "baby got back")
    @guest2 = Guest.new("Bobby", 40, "eye of the tiger")
    @guest3 = Guest.new("Isa", 70, "born to be wild")
    @guest4 = Guest.new("Winston", 50, "One legged man")
    @guest5 = Guest.new("Victor", 70, "ballad of mrs begg")
    @guest6 = Guest.new("Jack", 60, "ballad of mrs begg")

#create playlist with a nineties and eighties song hash.
    @playlist = [
      @nineties = {
        song1: Song.new("thunderstruck", "ac/dc", 1990),
        song2: Song.new("smells like teen spirit", "nirvana", 1991),
        song3: Song.new("baby got back", "sir mix-a-lot", 1992)
      },
      @eighties = {
        song1: Song.new("relax", "frankie goes to hollywood", 1984),
        song2: Song.new("eye of the tiger", "survivor", 1982),
        song3: Song.new("the power of love", "jennifer rush", 1985)
      }
    ]
  end

  def test_room_name
    assert_equal("Angus", @room1.name)
  end

  def test_room_guest_limit
    assert_equal(6, @room1.guest_limit)
  end

  def test_room_entry_fee
    assert_equal(30, @room1.entry_fee)
  end

  def test_return_song1_name_from_nineties_playlist
    assert_equal("thunderstruck", @playlist[0][:song1].name)
  end

  def test_return_song2_artist_name_from_eighties_playlist
    assert_equal("survivor", @playlist[1][:song2].artist)
  end

  def test_check_in_guest_to_room_when_rooms_empty
    @room1.check_in_guest(@guest1)
    assert_equal(1, @room1.count_guest_list())
  end

  def test_check_in_guest_when_room_is_full
    @room1.check_in_guest(@guest1)
    @room1.check_in_guest(@guest2)
    @room1.check_in_guest(@guest3)
    @room1.check_in_guest(@guest4)
    @room1.check_in_guest(@guest5)
    @room1.check_in_guest(@guest6)
    #create 7th guest object to add to room that is already at its limit of 6
    @guest7 = Guest.new("Pete The Jakey", 2, "survivor")
    assert_equal("Sorry, this rooms full!", @room1.check_in_guest(@guest7))
  end

  def test_check_out_guest_from_room
    @room1.check_in_guest(@guest1)
    @room1.check_out_guest(@guest1)
    assert_equal(0, @room1.count_guest_list())
  end

  def test_return_list_of_guests_in_room
    @room1.check_in_guest(@guest1)
    @room1.check_in_guest(@guest4)
    assert_equal(["Navid", "Winston"], @room1.return_guest_list_names())
  end

  def test_add_song_to_playlist
    requested_song = Song.new("We will rock you", "Queen", "1977")
    @room1.add_song_to_playlist(requested_song)
    assert_equal(1, @room1.count_playlist_songs())
  end

  def test_remove_song_from_playlist
    requested_song = Song.new("We will rock you", "Queen", "1977")
    @room1.add_song_to_playlist(requested_song)
    @room1.remove_song_from_playlist(requested_song)
    assert_equal(0, @room1.count_playlist_songs())
  end

  def test_check_if_guests_favourite_song_is_playing
    requested_song = Song.new("baby got back", "Sir Mix-a-Lot", "1992")
    @room1.add_song_to_playlist(requested_song)
    assert_equal("Whoo!", @guest1.check_if_favourite_song_is_playing(requested_song))
  end

  def test_guest_pay_entry_fee
    assert_equal(70, @guest1.pay_entry_fee(@room1.entry_fee))
  end

def test_bar_tab_tracks_payments
  @guest1.pay_entry_fee(@room1.entry_fee)
  @bar_tab.add_to_bill_tab(@room1.entry_fee)
  assert_equal(30,@bar_tab.bill_tab())
end

end
