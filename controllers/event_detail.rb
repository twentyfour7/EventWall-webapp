# frozen_string_literal: true

# event detail controller
class EventWall < Sinatra::Base

  get '/event/:event_id' do
    event_result = GetEventDetail.call(params)

    if event_result.success?

      event_detail = event_result.value
      org_result = GetOrgDetail.call(org_id: event_detail.organization_id.to_s)
      event_date = Date.parse(event_detail.datetime.split(' ')[0]).to_date
      event_time = event_detail.datetime.split(' ')[1]
      cover_img_url = nil
      cover_img_url = event_detail.cover_img_url if event_detail.respond_to? 'cover_img_url'
      # event_date = event_detail.datetime.nil? ? '' : DateTime.strptime(event_detail.datetime.split(' ')[0].sub('/', '-'), '%Y-%m-%d').to_date
      # event_time = event_detail.datetime.nil? ? '' : event_detail.datetime.split(' ')[1]

      @event = EventView.new(
        id = event_detail.id,
        title = event_detail.title,
        date = event_date,
        time = event_time,
        location = event_detail.location,
        event_type = event_detail.event_type,
        summary = event_detail.summary,
        url = event_detail.url,
        org_id = event_detail.organization_id,
        org_name = org_result.value.organization.name,
        cover_img_url = cover_img_url
      )
    else
      flash[:error] = event_result.value.message
      redirect '/'
    end

    slim :event_detail
  end
end
