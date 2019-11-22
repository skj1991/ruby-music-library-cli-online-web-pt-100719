class Song
  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(song_name, artist_obj = nil, genre_obj = nil)
    @name = song_name
    self.artist = artist_obj if artist_obj
    self.genre = genre_obj if genre_obj
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

  def self.create(name_of_song)
    song_obj = self.new(name_of_song)
    song_obj.save
    song_obj
  end

  def artist=(artist_instance)
    @artist = artist_instance
    artist_instance.add_song(self)
  end

  def genre=(genre_instance)
    @genre = genre_instance
    genre_instance.add_song(self)
  end

  def self.find_by_name(name)
    all.detect {|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    self.find_by_name(name) || create(name)
  end

  def self.new_from_filename(file)
    file = file.gsub(".mp3", "")
    artist, song, genre = file.split(" - ")
    song_artist = Artist.find_or_create_by_name(artist)
    song_genre = Genre.find_or_create_by_name(genre)
    new_song = Song.new(song, song_artist, song_genre)
  end

  def self.create_from_filename(file)
    song = self.new_from_filename(file)
    song.save
  end

end
