require('pg')
require_relative('../db/sql_runner')
require_relative("./customer")

class Film

  attr_reader :id
  attr_accessor :title, :price


  def initialize( options )
    @id = options['id'] if options['id'].to_i
    @title = options['title']
    @price = options['price'].to_i

  end

  def save
    sql = "INSERT INTO films
        (title, price)
        VALUES
        ($1, $2)
        RETURNING id"
    values = [@title, @price]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i

  end

  def update
    sql = "UPDATE films SET title = $1, price = $2 WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)

  end

  def customers
    sql = "SELECT customers.* FROM customers
            INNER JOIN tickets
            ON tickets.customer_id = customers.id
            WHERE film_id = $1"
    values = [@id]
    customers = SqlRunner.run(sql, values)
    return customers.map { |customer| Customer.new(customer) }
  end

  def self.find(id)
    sql = "SELECT *
    FROM films
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    film_hash = results.first
    film = Film.new(film_hash)
    return film
  end


  def self.all
    sql = "SELECT * FROM films"
    films = SqlRunner.run(sql)
    return films.map { |film| Film.new(film) }

  end

  def self.delete_all
    sql = " DELETE FROM films"
    SqlRunner.run(sql)

  end


end
