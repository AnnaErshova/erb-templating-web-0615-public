require 'pry'

class Movie 

attr_accessor :title, :release_date, :director, :summary

@@all = Array.new

  def initialize(title, release_date, director, summary)
    @title = title
    @release_date = release_date.to_i
    @director = director
    @summary = summary
    @@all << self
  end

  def self.all
    @@all
  end

  def self.reset_movies!
    @@all.clear
  end

  def self.make_movies! # assigns titles, release_dates, directors    
    # ...and now we parse
    File.read('spec/fixtures/movies.txt').each_line do |line|
      # or './spec/fixtures/movies.txt')
      # @title = line.split(" - ").first
      Movie.new(line.split(" - ")[0], line.split(" - ")[1], line.split(" - ")[2], line.split(" - ")[3])
      # Movie.new(*movie_array)
    end 
  end

  def self.recent # returns movies released during or after 2012   
    self.all.select { |movie| movie.release_date >= 2012 }
  end

  def url # "The Matrix" => "the_matrix.html"
    #title_array = Array.new
    #@title.split(" ").each do |word|
    #  title_array << word.downcase
    #end
    #url = "#{title_array.join("_")}.html"
    "#{self.title.gsub(" ","_").downcase}.html"
  end

end # end Class