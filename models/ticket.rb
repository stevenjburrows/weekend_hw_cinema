require('pg')
require_relative("../db/sql_runner")
require_relative("./film")
require_relative("./customer")

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize (options)
    @id = options['id'] if options['id'].to_i
    @customer_id = options['customer_id']
    @film_id = options['film_id']

  end

  def save()
    sql = "INSERT INTO tickets
            (customer_id, film_id)
          VALUES
            ($1, $2)
    RETURNING id"
    values = [@customer_id, @film_id]
    visit = SqlRunner.run( sql,values ).first
    @id = visit['id'].to_i
  end

  def customer
    sql = "SELECT * FROM customers
            WHERE customers.id = $1"
    values = [@customer_id]
    customer = SqlRunner.run(sql, values).first
    return Customer.new(customer)
  end

  def film
    sql = "SELECT * FROM films
            WHERE films.id = $1"
    values = [@film_id]
    film = SqlRunner.run(sql, values).first
    return Film.new(film)
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    tickets = SqlRunner.run(sql)
    result = tickets.map { |ticket| Ticket.new( ticket ) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

end
