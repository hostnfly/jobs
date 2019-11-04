require 'json'

namespace :populate_db_from_backend_file do
  desc "Populates the DB"
  task :populate, [:file] => :environment do |task, args|
    json_data = JSON.parse(File.read(args.file))

    json_data['listings'].each do |listing_params|
      Listing.create!(listing_params)
    end

    json_data['bookings'].each do |booking_params|
      Booking.create!(booking_params)
    end

    json_data['reservations'].each do |reservation_params|
      Reservation.create!(reservation_params)
    end
  end
end
