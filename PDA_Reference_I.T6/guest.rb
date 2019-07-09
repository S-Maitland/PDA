class Guest
  attr_reader :name, :favourite_song
  attr_accessor :wallet

  def initialize(name, wallet, favourite_song)
    @name = name
    @wallet = wallet
    @favourite_song = favourite_song
  end

  def check_if_favourite_song_is_playing(song)
    if song.name == @favourite_song
      return "Whoo!"
    end
  end

  def pay_entry_fee(amount)
    @wallet -= amount
  end

end
