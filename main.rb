require_relative 'src/to_cantor'
require_relative 'src/data'
require 'sinatra'
require 'chartkick'

get '/' do
  @title = 'Cantor Distribution'
  @data = get_data
  erb :chart
end
