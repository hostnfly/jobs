PRICE = { first_checkin: 10, last_checkout: 5, checkout_checkin: 10 }


input = {
  "listings": [
    { "id": 1, "num_rooms": 2 },
    { "id": 2, "num_rooms": 1 },
    { "id": 3, "num_rooms": 3 }
  ],
  "bookings": [
    { "id": 1, "listing_id": 1, "start_date": "2016-10-10", "end_date": "2016-10-15" },
    { "id": 2, "listing_id": 1, "start_date": "2016-10-16", "end_date": "2016-10-20" },
    { "id": 3, "listing_id": 2, "start_date": "2016-10-15", "end_date": "2016-10-20" }
  ],
  "reservations": [
    { "id": 1, "listing_id": 1, "start_date": "2016-10-11", "end_date": "2016-10-13" },
    { "id": 1, "listing_id": 1, "start_date": "2016-10-13", "end_date": "2016-10-15" },
    { "id": 1, "listing_id": 1, "start_date": "2016-10-16", "end_date": "2016-10-20" },
    { "id": 3, "listing_id": 2, "start_date": "2016-10-15", "end_date": "2016-10-18" }
  ]
}

def get_last_checkout(id, date, bookings)
  bookings.each do |booking|
      return false if booking[:listing_id] == id && booking[:end_date] == date
  end
  return true
end

def handle_cleanings(input)
  listings = input[:listings]
  bookings = input[:bookings]
  reservations = input[:reservations]
  result = []
  
  
  listings.each do |listing|
    # for each listing's booking i put new missions in result
    bookings.each do |booking|
      if listing[:id] == booking[:listing_id]
        result <<  {:listing_id => booking[:listing_id], :mission_type=> 'first_checkin', :date=> booking[:start_date], :price=> PRICE[:first_checkin] * listing[:num_rooms]}
        result <<  {:listing_id => booking[:listing_id], :mission_type=> 'last_checkout', :date=> booking[:end_date], :price=> PRICE[:last_checkout] * listing[:num_rooms]}
      end
    end
    # for each reservation,i make a checkout_checkin if last_checkout is missing
    reservations.each do |reservation|
      if listing[:id] == reservation[:listing_id] && get_last_checkout(reservation[:listing_id], reservation[:end_date], bookings)
        result <<  {:listing_id => reservation[:listing_id], :mission_type=> 'checkout_checkin', :date=> reservation[:end_date], :price=> PRICE[:checkout_checkin] * listing[:num_rooms]}
      end
    end
  end

  return {"missions": result}
  
end

p handle_cleanings(input)