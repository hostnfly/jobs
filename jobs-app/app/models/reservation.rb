# == Schema Information
#
# Table name: reservations
#
#  id           :integer          not null, primary key
#  start_date   :datetime         not null
#  end_date     :datetime         not null
#  is_cancelled :boolean
#  listing_id   :integer          not null
#
# Indexes
#
#  index_reservations_on_listing_id  (listing_id)
#

class Reservation < ApplicationRecord
  belongs_to :listing, inverse_of: :reservations

  scope :active, -> { where(is_cancelled: [false, nil]) }

  validate :dates_must_be_sorted_correctly, :reservations_must_not_overlap

  private
  def dates_must_be_sorted_correctly
    if !!start_date && !!end_date && end_date < start_date
      errors.add(:end_date, "cannot be past to start_date")
    end
  end

  def reservations_must_not_overlap
    overlap_relation = Reservation.where(listing_id: listing_id)
      .where(
        'DATE(reservations.start_date) < DATE(?) AND DATE(reservations.end_date) > DATE(?)',
        end_date, start_date
      )

    if overlap_relation.exists?
      errors.add(:start_date, "canot overlap another reservation for this listing")
    end
  end
end
