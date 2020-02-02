class Song
  attr_accessor :name, :artist, :genre  #artist returns the artist of the song (song belongs to artist)/#artist= assigns an artist to the song (song belongs to artist)
        @@all = []
      def initialize(name, artist = nil, genre = nil)   #initialize can be invoked with an optional second argument, an Artist object to be assigned to the song's 'artist' property (song belongs to artist)
        @name = name
        self.artist=artist if artist
         self.genre=genre if genre     #invokes #genre= instead of simply assigning to a @genre instance variable to ensure that associations are created upon initialization
      end

      def self.all
        @@all
      end

      def self.destroy_all
           @@all.clear
      end

      def save
        # self.class.all << self
        @@all << self
      end

      def self.create(name)
         song = Song.new(name)
         song.save
         song
      end

      def artist=(artist)
        @artist = artist
        artist.add_song(self)
      end

      def genre=(genre)
        @genre = genre
        if !(genre.songs.include?(self))
        genre.songs << self

        end
      end

      def self.find_by_name(name)       #.find_by_name finds a song instance in @@all by the name property of the song
        all.detect {|song| song.name == name}
      end

      def self.find_or_create_by_name(name)   #.find_or_create_by_name  returns (does not recreate) an existing song with the provided name if one exists in @@all    invokes .find_by_name instead of re-coding the same functionality  creates a song if an existing match is not found  invokes .create instead of re-coding the same functionality
                find_by_name(name) || create(name)
        end

        def self.new_from_filename(filename)
              info = filename.split(" - ")
              artist, name, genre = info[0], info[1], info[2].gsub( ".mp3" , "")


              genre = Genre.find_or_create_by_name(genre)
              artist = Artist.find_or_create_by_name(artist)
              new(name,artist,genre)
        end

        def self.create_from_filename(filename)
            new_from_filename(filename).tap{ |s| s.save}
        end


end
