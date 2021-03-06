require_relative('../db/sql_runner.rb')
require_relative('customer.rb')
require_relative('ticket.rb')

class Film
  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @title = options['title']
    @price = options['price'].to_i
    @id = options['id'].to_i() if options['id']
  end

  def save()
    sql = 'INSERT INTO films (
      title,
      price
    )
    VALUES ($1, $2)
    RETURNING id
    '
    values = [@title, @price]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.all()
    sql = 'SELECT * FROM films'
    results = SqlRunner.run(sql)
    return results.map {|film| Customer.new(film)}
  end

  def update()
    sql = 'UPDATE films SET(title, price) = ($1, $2) WHERE id = $3 '
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def delete_all()
    sql = 'DELETE FROM films'
    SqlRunner.run(sql)
  end

  def customers()
    sql = 'SELECT customers.* FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id WHERE tickets.film_id = $1'
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map{|customer| Customer.new(customer)}
  end

  def customer_count()
    sql = 'SELECT COUNT(*) FROM tickets WHERE film_id = $1'
    values =[@id]
    return SqlRunner.run(sql, values)
  end
end
