class Genre
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :songs

  @@all = []

  def initialize(name)
    @songs = []
    @name = name
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def save
    @@all << self
  end

  def self.create(genre_type)
    genre_obj = self.new(genre_type)
    genre_obj.save
    genre_obj
  end

  def add_song(song_obj)
    song_obj.artist = self unless song_obj.artist != nil
    @songs << song_obj unless @songs.detect {|s_obj| s_obj == song_obj}
  end

  def artists
    songs.collect do |song|
      song.artist
    end.uniq
  end

end
