class CreateDevices < ActiveRecord::Migration[5.0]
  def change
    create_table :devices do |t|
      t.integer :device_type
      t.string :uuid
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
