class AddListingsReservationsBookingsMissionsTables < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.integer :num_rooms, null: false
    end

    create_table :bookings do |t|
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.boolean :is_cancelled

      t.references :listing, foreign_key: true, null: false
    end

    create_table :reservations do |t|
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.boolean :is_cancelled

      t.references :listing, foreign_key: true, null: false
    end

    create_table :missions do |t|
      t.string :mission_type, null: false
      t.datetime :date, null: false
      t.float :price, null: false

      t.references :listing, foreign_key: true, null: false
    end
  end
end
