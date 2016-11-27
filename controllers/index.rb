# frozen_string_literal: true

# Event wall index controller
class EventWall < Sinatra::Base
  get '/?' do
    slim :event
  end
end
