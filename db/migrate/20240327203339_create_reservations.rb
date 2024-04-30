class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|r
      t.references :sender, null: false, foreign_key: {to_table: :users}
      t.references :event, null: false, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
