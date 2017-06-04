
class WhichFilm

attr_accessor :customer_name, :title, :show_time

  def initialize(options)
    @customer_name = options['Customer']
    @title = options['Title']
    @show_time = options['Show Time']
  end

end