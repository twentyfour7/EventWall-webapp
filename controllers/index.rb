# frozen_string_literal: true

# EventWall index controller
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

    slim :index
  end
end
