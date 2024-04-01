class RemoveSendersForeignKeyFromReservations < ActiveRecord::Migration[7.0]
  def change
    # Remove the incorrect foreign key if it exists
    remove_foreign_key :reservations, :senders if foreign_key_exists?(:reservations, :senders)
    add_foreign_key :reservations, :users, column: :sender_id
  end
end
