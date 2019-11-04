# == Schema Information
#
# Table name: bookings
#
#  id           :integer          not null, primary key
#  start_date   :datetime         not null
#  end_date     :datetime         not null
#  is_cancelled :boolean
#  listing_id   :integer          not null
#
# Indexes
#
#  index_bookings_on_listing_id  (listing_id)
#

class Booking < ApplicationRecord
  belongs_to :listing, inverse_of: :bookings

  scope :active, -> { where(is_cancelled: [false, nil]) }

  validate :dates_must_be_sorted_correctly, :bookings_must_not_overlap

  private
  def dates_must_be_sorted_correctly
    if !!start_date && !!end_date && end_date < start_date
      errors.add(:end_date, "can't be past to start_date")
    end
  end

  def bookings_must_not_overlap
    overlap_relation = Booking.where(listing_id: listing_id)
      .where(
        'DATE(bookings.start_date) < DATE(?) AND DATE(bookings.end_date) > DATE(?)',
        end_date, start_date
      )

    if overlap_relation.exists?
      errors.add(:start_date, "canot overlap another booking for this listing")
    end
  end
end
