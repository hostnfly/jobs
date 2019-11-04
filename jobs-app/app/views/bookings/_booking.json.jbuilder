json.extract! booking, :id, :start_date, :end_date, :is_cancelled, :listing_id
json.url booking_url(booking, format: :json)
