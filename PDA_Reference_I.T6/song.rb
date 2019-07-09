class Song
attr_reader :name, :artist, :release_year

  def initialize(name, artist, release_year)
    @name = name
    @artist = artist
    @release_year = release_year
  end

end
