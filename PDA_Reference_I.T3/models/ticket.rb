require_relative('../db/sql_runner.rb')

class Ticket
  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(options)
    @customer_id = options['customer_id']
    @film_id = options['film_id']
    @id = options['id'].to_i() if options['id']
  end

  def save()
    sql = 'INSERT INTO tickets (
      customer_id,
      film_id
    )
    VALUES ($1, $2)
    RETURNING id
    '
    values = [@customer_id, @film_id]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.all()
    sql = 'SELECT * FROM tickets'
    results = SqlRunner.run(sql)
    return results.map {|ticket| Ticket.new(ticket)}
  end

  def update()
    sql = 'UPDATE tickets SET(customer_id, film_id) = ($1, $2) WHERE id = $3 '
    values = [@customer_id, @film_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM tickets WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def delete_all()
    sql = 'DELETE FROM tickets'
    SqlRunner.run(sql)
  end

end
