class CreateSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :sessions do |t|
      t.string :access_token
      t.string :refresh_token
      t.datetime :expire_at
      t.belongs_to :device, index: true

      t.timestamps
    end
  end
end
