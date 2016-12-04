# frozen_string_literal: true

# Event wall index controller
class EventWall < Sinatra::Base
  get '/?' do
    result = SearchEvents.call(params)

    if result.success?
      @search_result = result.value
    else
      flash[:error] = result.value.message
      redirect '/'
    end

    slim :event
  end
end
