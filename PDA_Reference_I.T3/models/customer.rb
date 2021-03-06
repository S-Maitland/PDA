require_relative('../db/sql_runner.rb')
require_relative('film.rb')
require_relative('ticket.rb')

class Customer
  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @name = options['name']
    @funds = options['funds'].to_i
    @id = options['id'].to_i() if options['id']
  end

  def save()
    sql = 'INSERT INTO customers (
      name,
      funds
    )
    VALUES ($1, $2)
    RETURNING id
    '
    values = [@name, @funds]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.all()
    sql = 'SELECT * FROM customers'
    results = SqlRunner.run(sql)
    return results.map {|customer| Customer.new(customer)}
  end

  def update()
    sql = 'UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3'
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = 'DELETE FROM customers'
    SqlRunner.run(sql)
  end

  def films()
    sql = 'SELECT films.* FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE customer_id = $1'
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map{|film| Film.new(film)}
  end

  def buy_ticket(film)
    @funds -= film.price
    newTicket = Ticket.new({
      'customer_id' => @id,
      'film_id' => film.id
      })
      newTicket.save()
    update()
  end

  def ticket_count()
    sql = 'SELECT COUNT(*) FROM tickets WHERE customer_id = $1'
    values =[@id]
    return SqlRunner.run(sql, values)
  end

end
