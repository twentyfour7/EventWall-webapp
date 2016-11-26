require 'sinatra'

class EventWall < Sinatra::Base

  get "/?" do
    slim :index
  end

  post '/org/?' do
    slim :test
  end
end
