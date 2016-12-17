# frozen_string_literal: true

# org detail controller
class EventWall < Sinatra::Base

  get '/org/:org_id' do
    result = GetOrgDetail.call(params)
    if result.success?
      org_detail = result.value
      
      @org = OrgView.new(
        id = org_detail.id,
        slug = org_detail.slug,
        name = org_detail.name,
        uri = org_detail.uri
      )
      # @event = EventDetailView.new(event_detail)
    else
      flash[:error] = result.value.message
      redirect '/'
    end

    slim :organizer
  end
end
