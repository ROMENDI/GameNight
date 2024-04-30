class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :date_time
      t.string :location
      t.integer :capacity
      t.references :game, null: false, foreign_key: true
      t.references :host, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
