require('pg')
require_relative('../db/sql_runner')
require_relative("./film")

class Customer

  attr_reader :id
  attr_accessor :name, :funds


  def initialize( options )
    @id = options['id'] if options['id'].to_i
    @name = options['name']
    @funds = options['funds'].to_i

  end

  def save
    sql = "INSERT INTO customers
        (name, funds)
        VALUES
        ($1, $2)
        RETURNING id"
    values = [@name, @funds]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i

  end

  def update
    sql = "UPDATE customers SET name = $1, funds = $2 WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)

  end

  def films
    sql = "SELECT films.* FROM films
            INNER JOIN tickets
            ON tickets.film_id = films.id
            WHERE customer_id = $1"
    values = [@id]
    films = SqlRunner.run(sql, values)
    return films.map { |film| Film.new(film) }
  end

  def self.all
    sql = "SELECT * FROM customers"
    customers = SqlRunner.run(sql)
    return customers.map { |customer| Customer.new(customer) }

  end

  def self.delete_all
    sql = " DELETE FROM customers"
    SqlRunner.run(sql)

  end


end
