class FixHostForeignKeyInEvents < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :events, :hosts if foreign_key_exists?(:events, :hosts)
    add_foreign_key :events, :users, column: :host_id
  end
end
