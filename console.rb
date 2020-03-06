require('pry')
require_relative('./models/customer')
require_relative('./models/film')
require_relative('./models/ticket')

Customer.delete_all
Film.delete_all

customer1 = Customer.new({'name' => 'Slash', 'funds' => 100})
customer1.save
customer2 = Customer.new({'name' => 'Axel Rose', 'funds' => 200})
customer2.save
customer3 = Customer.new({'name' => 'Duff McKagan', 'funds' => 150})
customer3.save

customer3.name = 'Steven Adler'
customer3.update

film1 = Film.new({'title' => 'Aliens', 'price' => 5})
film1.save
film2 = Film.new({'title' => 'Tremours', 'price' => 4})
film2.save
film3 = Film.new({'title' => 'Pacific Rim', 'price' => 6})
film3.save

film3.title = 'Halloween'
film3.update

ticket1 = Ticket.new({'customer_id' =>customer1.id, 'film_id' => film1.id})
ticket1.save
ticket2 = Ticket.new({'customer_id' =>customer2.id, 'film_id' => film2.id})
ticket2.save
ticket3 = Ticket.new({'customer_id' =>customer1.id, 'film_id' => film2.id})
ticket3.save


binding.pry
nil
