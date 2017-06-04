require 'pry-byebug'

require_relative '../models/customer'
require_relative '../models/film'
require_relative '../models/ticket'
require_relative '../models/which_film'

Customer.delete_all()
Film.delete_all()
Ticket.delete_all()

customer1 = Customer.new({
  'name' => 'stu',
  'funds' => 1000
  })
customer1.save()

customer2 = Customer.new({
  'name' => 'cobells',
  'funds' => 50
  })
customer2.save()

customer3 = Customer.new({
  'name' => 'jia bird stop',
  'funds' => 50
  })
customer3.save()

film1 = Film.new({
  'title' => 'Alien: Coveting',
  'price' => 10
  })
film1.save

film2 = Film.new({
  'title' => 'Baewatch',
  'price' => 10
  })
film2.save

film3 = Film.new({
  'title' => 'Wonderful Woman',
  'price' => 10
  })
film3.save

ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film1.id,
  'show_time' => '20:30'
  })
ticket1.save

ticket2 = Ticket.new({
  'customer_id' => customer2.id,
  'film_id' => film1.id,
  'show_time' => '20:30'
  })
ticket2.save

ticket3 = Ticket.new({
  'customer_id' => customer3.id,
  'film_id' => film2.id,
  'show_time' => '22:00'
  })
ticket3.save

ticket4 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film3.id,
  'show_time' => '23:00'
  })
ticket4.save


binding.pry
nil
# customer3.name = 'jpeg'
# customer3.funds = 13
# customer3.update

