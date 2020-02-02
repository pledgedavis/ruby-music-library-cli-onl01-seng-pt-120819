class Artist
   extend Concerns::Findable    #extends the Concerns::Findable module
    attr_accessor :name, :songs    #name=can set the name of an artist/#name retrieves the name of an artist

     @@all = []    #@@all is initialized as an empty array

    def initialize(name)
       @name = name      #initialize accepts a name for the new artist

       @songs = []          #initialize creates a 'songs' property set to an empty array (artist has many songs)
    end

    def self.all
        @@all
    end

    def self.destroy_all      #.destroy_all resets the @@all class variable to an empty array
          @@all.clear
    end

    def save                 #save adds the Artist instance to the @@all class variable
       @@all << self
    end

    def self.create(name)       # .create initializes and saves the artist
      artist = self.new(name)
      artist.save
      artist
    end

   def add_song(song)
     song.artist = self unless song.artist

        songs << song unless songs.include?(song)


   end

   def genres
     songs.collect {
       |song| song.genre
     }.uniq

   end






end
