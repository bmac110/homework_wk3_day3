require("pry-byebug")
require_relative("./models/artists.rb")
require_relative("./models/albums.rb")

Albums.delete_all()
Artists.delete_all()


artist1 = Artists.new(
  {
    "name" => "The Prodigy"
  }
)

artist2 = Artists.new(
  {
    "name" => "Daft Punk"
  }
)

artist1.save()
artist2.save()

album1 = Albums.new(
  {
    "name" => "The Fat of the Land",
    "genre" => "Dance",
    "artist_id" => artist1.id
  }
)

album2 = Albums.new(
  {
    "name" => "Discovery",
    "genre" => "Dance",
    "artist_id" => artist2.id
  }
)

album1.save()
album2.save()

albums = Albums.all()


binding.pry

nil
