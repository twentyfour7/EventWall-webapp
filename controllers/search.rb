# frozen_string_literal: true

# EventWall search controller
class EventWall < Sinatra::Base
  extend Econfig::Shortcut

  get '/search' do
    redirect '/'
  end
end
