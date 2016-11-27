# Event wall index controller
class EventWall < Sinatra::Base
  get '/?' do
    slim :index
  end

  post '/search/?' do
    result = SearchEvents.call(params)

    if result.success?
      puts 'success'
      @events = result.value
    end

    slim :search
  end
end
