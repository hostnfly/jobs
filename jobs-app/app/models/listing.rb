# == Schema Information
#
# Table name: listings
#
#  id        :integer          not null, primary key
#  num_rooms :integer          not null
#

class Listing < ApplicationRecord
  has_many :bookings, inverse_of: :listing
  has_many :reservations, inverse_of: :listing
  has_many :missions, inverse_of: :listing
end
