require_relative '../db/sql_runner'

class Film

attr_accessor :id, :title, :price

def initialize(options)
  @id = options['id'].to_i if options['id']
  @title = options['title']
  @price = options['price']
end

def save()
  sql = "INSERT INTO films (title, price) VALUES ('#{@title}', #{@price}) RETURNING *;"
  result = SqlRunner.run(sql)
  @id = result[0]['id'].to_i
end

def update()
  sql = "UPDATE films SET (title, price) = ('#{@title}', #{@price}) WHERE id = #{@id};"
  result = SqlRunner.run(sql)
end

def delete()
  sql = "DELETE FROM films WHERE id = #{@id}"
  result = SqlRunner.run(sql)
end

def customers()
  sql ="SELECT films.title AS \"Title\", tickets.show_time as \"Show Time\", customers.name AS \"Customer\" FROM films INNER JOIN tickets ON films.id = tickets.film_id INNER JOIN customers ON tickets.customer_id = customers.id WHERE films.id = #{@id};"
  results = SqlRunner.run(sql)
  return results.map {|result| WhichFilm.new(result)}
end

def how_many_customers()
  sql = "SELECT customers.name FROM films INNER JOIN tickets on films.id = tickets.film_id INNER JOIN customers on customers.id = tickets.customer_id WHERE films.id = #{@id};"
  results = SqlRunner.run(sql).count
  
end

def self.all()
  sql = "SELECT * FROM films;"
  results = SqlRunner.run(sql)
  return results.map {|result| Film.new(result)}
end

def self.delete_all()
  sql = "DELETE FROM films;"
  SqlRunner.run(sql)  
end

end