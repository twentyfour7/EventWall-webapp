class EventWall < Sinatra::Base

  get "/?" do
    slim :index
  end

  post '/event/?' do
    result = SearchEvents.call(params)

    redirect '/'
  end
end
