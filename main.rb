require_relative 'src/to_cantor'
require 'sinatra'
require 'chartkick'

get '/' do
  @title = 'TEST'
  @data = [
    %w[Washington 1789-04-29 1797-03-03],
    %w[Adams 1797-03-03 1801-03-03],
    %w[Jefferson 1801-03-03 1809-03-03]
  ]
  erb :chart
end
