# == Schema Information
#
# Table name: missions
#
#  id           :integer          not null, primary key
#  mission_type :string           not null
#  date         :datetime         not null
#  price        :float            not null
#  listing_id   :integer          not null
#
# Indexes
#
#  index_missions_on_listing_id  (listing_id)
#

class Mission < ApplicationRecord
  belongs_to :listing, inverse_of: :missions

  class MissionType
    FIRST_CHECKIN = 'first_checkin'
    LAST_CHECKOUT = 'last_checkout'
    CHECKOUT_CHECKIN = 'checkout_checkin'

    def self.values
      [FIRST_CHECKIN, LAST_CHECKOUT, CHECKOUT_CHECKIN]
    end
  end

  validates :mission_type, inclusion: {
    in: MissionType.values,
    message: "%{value} is not a valid mission_type"
  }
end
