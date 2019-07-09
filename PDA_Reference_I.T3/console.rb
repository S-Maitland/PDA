require('pry-byebug')
require_relative('models/customer.rb')
require_relative('models/film.rb')
require_relative('models/ticket.rb')

customer1 = Customer.new({
  'name' => 'Jack Jarvis',
  'funds' => 60
  })
customer1.save()

customer2 = Customer.new({
  'name' => 'Victor Mcdood',
  'funds' => 70
  })
customer2.save()

film1 = Film.new({
  'title' => 'Avengers: Infinity War',
  'price' => '11'
  })
film1.save()

film2 = Film.new({
  'title' => '8 Mile',
  'price' => '11'
  })
film2.save()

customer2.name = 'Victor McDade'
customer2.update()

film1.title = 'Avengers: Endgame'
film1.update()

ticket1 = Ticket.new({
'customer_id' => customer1.id,
'film_id' => film1.id
})
ticket1.save()

ticket2 = Ticket.new({
'customer_id' => customer2.id,
'film_id' => film1.id
})
ticket2.save()

customer1.buy_ticket(film2)

binding.pry
nil
