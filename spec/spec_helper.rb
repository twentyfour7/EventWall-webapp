# frozen_string_literal: true
ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'minitest/rg'

require 'watir'
require 'headless'
require 'page-object'

require './init.rb'

EXISTS_ORG_SLUG = 'nthuion'.freeze
INVALID_ORG_SLUG = 'cowbeinthu'.freeze

HOST = 'http://localhost:9000/'.freeze

# Helper methods
def homepage
  HOST
end

def event_search_page(slug)
  "#{HOST}/search/#{slug}"
end
