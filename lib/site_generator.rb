require 'ERB'

class SiteGenerator

  def make_index! # does not use ERB
    assign_html
    File.write('_site/index.html', @html)
  end

  def assign_html # basically assign a fake .html.erb file
    @html = <<-HTML
      <!DOCTYPE html>
      <html>
        <head>
          <title>Movies</title>
        </head>
        <body>
        <ul> 
          #{index_movie_list}
        </ul>
        </body>
      </html>
    HTML
  end

  def generate_pages! # allowed to use ERB
    make_directory
    generate
  end 

  def make_directory
    FileUtils.rm_rf('./_site/movies/') # just in case
    FileUtils.mkdir('_site/movies/')
  end

  def generate
    template = ERB.new(File.read('./lib/templates/movie.html.erb'))
    Movie.all.each do |movie|
      File.write("./_site/movies/#{movie.url}", template.result(binding))
    end
  end

  def index_movie_list
    movies = ""
    Movie.all.each do |movie|
      list_movie = <<-HTML
    <li><a href="movies/#{movie.url}">#{movie.title}</a></li>
    HTML
    movies << list_movie
    end
    movies
  end

  def movie_list_for_movie_pages # creates an html page for each movie in the _site/movies directory
    movies = ""
    Movie.all.each do |movie|
      #working with file names from url method
      html_list_movie = <<-HTML
        <li><a href="#{movie.url}">#{movie.title}</a></li> 
      HTML
      movies << html_list_movie
    end
    movies
  end

end # end class



