module Missions
  class GenerateService
    attr_reader :listings

    def initialize(listings: nil)
      @listings = listings
    end

    def perform
      selected_listings.each do |listing|
        compute_first_and_last_checkin_missions(listing)

        compute_checkout_checkin_missions(listing)
      end
    end

    private
    def selected_listings
      return listings if !!listings

      Listing.all
    end

    def compute_first_and_last_checkin_missions(listing)
      listing.bookings.active.each do |booking|
        listing.missions.create!(
          mission_type: Mission::MissionType::FIRST_CHECKIN,
          date: booking.start_date,
          price: 10*listing.num_rooms
        )

        listing.missions.create!(
          mission_type: Mission::MissionType::LAST_CHECKOUT,
          date: booking.end_date,
          price: 5*listing.num_rooms
        )
      end
    end

    def compute_checkout_checkin_missions(listing)
      Reservation.joins(listing: :bookings)
      .where('DATE(reservations.start_date) >= DATE(bookings.start_date) AND DATE(reservations.end_date) < DATE(bookings.end_date)')
      .where(listings: {id: listing.id})
      .each do |reservation|
        listing.missions.create!(
          mission_type: Mission::MissionType::CHECKOUT_CHECKIN,
          date: reservation.end_date,
          price: 10*listing.num_rooms
      )
      end
    end
  end
end
