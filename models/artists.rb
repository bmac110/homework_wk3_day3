require_relative("../db/sql_runner.rb")
require_relative("./albums.rb")

class Artists

  attr_accessor :name
  attr_reader :id

  def initialize(artist)
    @id = artist["id"].to_i() if artist["id"]
    @name = artist["name"]
  end

  def save()
    sql = "INSERT INTO artists(name)
    VALUES($1) RETURNING id"

    values = [@name]

    result = SqlRunner.run(sql, values)

    @id = result[0]["id"].to_i()
  end

  def Artists.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM artists"
    artists = SqlRunner.run(sql)
    return artists.map{|artist| Artists.new(artist)}
  end

  def albums()
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [@id]
    albums = SqlRunner.run(sql, values)
    return albums.map{|album| Albums.new(album)}

  end

  def update()
    sql = "UPDATE artists SET
    (name) = ($1) WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)

  end

  def delete(id)
    sql = "DELETE FROM artists WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    artists = SqlRunner.run(sql, values)[0]
    return Artists.new(artists)
  end


end
