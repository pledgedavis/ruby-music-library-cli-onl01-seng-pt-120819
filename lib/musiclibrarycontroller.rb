 require 'pry'
class MusicLibraryController
  def initialize(path = './db/mp3s')
      importer = MusicImporter.new(path)
      importer.import
    end

    def call
      input = ''
      while input != 'exit'
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      input = gets.chomp

      case input
      when 'list songs'
        self.list_songs
      when 'list artists'
        self.list_artists
      when 'list genres'
        self.list_genres
      when 'list artists'
        self.list_artists
      when 'list artist'
        self.list_songs_by_artist
      when 'list genre'
        self.list_songs_by_genre
      when 'play song'
        self.play_song
      else
        "Type in a valid request please"
      end

    def list_songs
      #  binding.pry

        Song.all.sort {|a,b| a.name <=> b.name}.each.with_index(1) do |song, i|
            puts "#{i}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
          end
    end
    
    def list_artists
          # Artist.all.sort {|a,b| a.name <=> b.name}.each.with_index(1) do |artist, i|
          # puts "#{i}. #{artist.song.name} - #{artist.name} - #{artist.genre.name}"
          artists = Artist.all.sort {|a,b| a.name <=> b.name}
            artists.each.with_index(1) {|artist, i| puts "#{i}. #{artist.name}"}
    end

    def list_genres
        genres = Genre.all.sort {|a,b| a.name <=> b.name}
        genres.each.with_index(1) {|genre, i| puts "#{i}. #{genre.name}"}
      end

    end
  end






end