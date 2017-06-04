require_relative '../db/sql_runner'

class Ticket

attr_accessor :id, :customer_id, :film_id, :show_time

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
    @show_time = options['show_time']
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id, show_time) VALUES (#{@customer_id}, #{@film_id}, '#{@show_time}') RETURNING *"
    result = SqlRunner.run(sql)
    @id = result[0]['id'].to_i
    update_customer_funds()
  end

  def price()
    sql = "SELECT films.price from films INNER JOIN tickets ON tickets.film_id = films.id WHERE tickets.id = #{@id}"
    price = SqlRunner.run(sql)[0]['price'].to_i
    return price    
  end

def customer_funds()
  sql = "SELECT customers.funds FROM customers WHERE customers.id = #{@customer_id};"
  customer_funds = SqlRunner.run(sql)
  return customer_funds[0]['funds'].to_i
end

def update_customer_funds
  new_amount = customer_funds() - price()
  sql = "UPDATE customers SET funds = #{new_amount} WHERE customers.id = #{@customer_id}"
  update = SqlRunner.run(sql)
end

  def update()
    sql = "UPDATE tickets SET (customer_id, film_id, show_time) = (#{@customer_id}, #{@film_id}, '#{@show_time}') WHERE tickets.id = #{@id};"
    result = SqlRunner.run(sql)    
  end

  def delete()
    sql = "DELETE FROM tickets WHERE tickets.id = #{@id};"
    SqlRunner.run(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM tickets;"
    SqlRunner.run(sql)    
  end

def self.all()
  sql = "SELECT * FROM tickets;"
  results = SqlRunner.run(sql)
  return results.map {|result| Ticket.new(result)}
end


end