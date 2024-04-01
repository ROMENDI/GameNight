class FixSenderForeignKeyInReservations < ActiveRecord::Migration[7.0]
  def change
    def change
      remove_foreign_key :reservations, column: :sender_id if foreign_key_exists?(:reservations, :sender_id)
      add_foreign_key :reservations, :users, column: :sender_id
    end
  end
end
