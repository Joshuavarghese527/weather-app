require 'sinatra'
require 'config_env'
require_relative 'models/weather.rb' 
require 'redis'

ConfigEnv.init("#{__dir__}/config/env.rb")
REDIS = Redis.new(url: ENV['REDIS_URL'])

set :port, 3000

get '/' do
  @cities = [
    "San Francisco",
    "London",
    "Tokyo",
    "Moscow",
    "New York",
    "Cairo"
  ]

  @city = params[:city] || "New York"
  weather = Weather.new(@city)
  @temp = weather.temp.round
  @icons = weather.icons
  erb :index
end