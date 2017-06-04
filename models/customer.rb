require_relative '../db/sql_runner'

class Customer

attr_accessor :id, :name, :funds

def initialize(options)
  @id = options['id'].to_i if options['id']
  @name = options['name']
  @funds = options['funds']  
end

def save()
  sql = "INSERT INTO customers (name, funds) VALUES ('#{@name}', '#{@funds}') RETURNING *;"
  result = SqlRunner.run(sql)
  @id = result[0]['id'].to_i
end

def update()
  refresh_balance()
  sql = "UPDATE customers SET (name, funds) = ('#{@name}', #{@funds}) WHERE customers.id = #{@id};"
  result = SqlRunner.run(sql)  
end

def refresh_balance
  sql = "SELECT customers.funds FROM customers WHERE customers.id = #{@id};"
  @funds = SqlRunner.run(sql)[0]['funds'].to_i
  
end

def delete()
  sql = "DELETE FROM customers WHERE id = #{@id};"
  SqlRunner.run(sql)
end

def which_films()
  sql = "SELECT customers.name AS \"Customer\", films.title AS \"Title\", tickets.show_time AS \"Show Time\" FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id INNER JOIN films on films.id = tickets.film_id WHERE customers.id = #{@id};"
  results = SqlRunner.run(sql)
  return results.map {|result| WhichFilm.new(result)}
end

def how_many_tickets()
  sql = "SELECT films.title FROM customers INNER JOIN tickets on customers.id = tickets.customer_id INNER JOIN films on tickets.film_id = films.id WHERE customers.id = #{@id};"  
  results = SqlRunner.run(sql).count
end

def self.all()
  sql = "SELECT * FROM customers;"
  results = SqlRunner.run(sql)
  return results.map {|result| Customer.new(result)}
end

def self.delete_all()
  sql = "DELETE FROM customers"
  SqlRunner.run(sql)  
end

end