# frozen_string_literal: true
require 'sinatra'

# Event wall base controller
class EventWall < Sinatra::Base
  extend Econfig::Shortcut

  configure do
    Econfig.env = settings.environment.to_s
    Econfig.root = File.expand_path('..', settings.root)
  end

  use Rack::Session::Cookie
  use Rack::Flash

  set :views, File.expand_path('../../views_html', __FILE__)
  set :public_dir, File.expand_path('../../public', __FILE__)

  after do
    content_type 'text/html'
  end
end
