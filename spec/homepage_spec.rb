# frozen_string_literal: true
require_relative 'spec_helper'

describe 'Homepage' do
  before do
    @browser = Watir::Browser.new unless @browser
  end

  after do
    @browser.close
  end

  describe 'Page elements' do
    it '(HAPPY) should see website features' do
      # GIVEN
      @browser.goto homepage
      @browser.title.must_include 'Campus Activity Board'
      @browser.a(class: 'navbar-brand').text.must_include 'EventWall'
    end

    it '(HAPPY) should see content' do
      # GIVEN
      @browser.goto homepage

      # THEN
      # @browser.trs(class: 'groups_row').count.must_be :>=, 1
      # @browser.span(class: 'group_name').text.must_include 'Service'
      # @browser.span(class: 'group_url').text.must_include 'facebook'
    end
  end

  describe 'Search an event' do
    it '(HAPPY) should be able to add a real group' do
      # GIVEN: on the homepage
      @browser.goto homepage

      # WHEN: search a valid organization slug
      @browser.text_field(class: 'search-bar').set(EXISTS_ORG_SLUG)
      @browser.button(class: 'search-btn').click

      # THEN: event should be present on homepage
      event_card = @browser.div(class: 'event-card')
      event_card.div(class: 'caption').h3.text.length.must_be :>, 0
      # event_card_description = event_card.div(class: 'activity-info')
      # event_card_description.text.must_include 'Analytics'

      # and danger flash notice should be seen
      # flash_notice = @browser.div(class: 'alert')
      # flash_notice.text.must_include 'added'
      # flash_notice.attribute_value('class').must_include 'success'
    end

    it '(SAD) should alert user if no result found' do
      # GIVEN: on the homepage
      @browser.goto homepage

      @browser.text_field(class: 'search-bar').set(INVALID_ORG_SLUG)
      @browser.button(class: 'search-btn').click

      # THEN: danger flash notice should be seen
      flash_notice = @browser.div(class: 'alert')
      flash_notice.attribute_value('class').must_include 'danger'
    end
  end
end
