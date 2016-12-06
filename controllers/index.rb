# frozen_string_literal: true

# Event wall index controller
class EventWall < Sinatra::Base
  get '/?' do
    result = SearchEvents.call(params)

    if result.success?
      event_search_result = result.value
      @search_result = EventCardView.new(event_search_result)
    else
      flash[:error] = result.value.message
      redirect '/'
    end

    slim :event_card
  end

  post '/search/?' do
    result = SearchEvents.call(params)

    if result.success?
      event_search_result = result.value
      @search_result = EventCardView.new(event_search_result)
    else
      flash[:error] = result.value.message
      redirect '/'
    end

    slim :event_card
  end
end
