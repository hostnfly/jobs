json.extract! reservation, :id, :start_date, :end_date, :is_cancelled, :listing_id
json.url reservation_url(reservation, format: :json)
