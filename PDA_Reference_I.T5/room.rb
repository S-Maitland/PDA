class Room
  attr_reader :name, :guest_limit, :entry_fee
  attr_accessor :guest_list, :playlist

  def initialize(name, guest_limit, entry_fee)
    @name = name
    @guest_limit = guest_limit
    @entry_fee = entry_fee
    @guest_list = []
    @playlist = []
  end

  def count_guest_list()
    return guest_list.size()
  end

  def count_playlist_songs
    return playlist.size()
  end

  def check_in_guest(guest)
    if @guest_list.size() < @guest_limit
      @guest_list << guest
    else
      return "Sorry, this rooms full!"
    end
  end

  def check_out_guest(guest)
    if @guest_list.include? (guest)
      @guest_list.delete(guest)
    else
      return "Sorry, that guest isn't in this room!"
    end
  end

  def return_guest_list_names()
    @guest_list.map {|guest| guest.name()}
  end

  def add_song_to_playlist(song)
    @playlist << song
  end

  def remove_song_from_playlist(song)
    @playlist.delete(song)
  end

end
