class CreateUserMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :user_messages do |t|
      t.belongs_to :user,     index: true
      t.belongs_to :message,  index: true
      t.boolean :read,        null: false, default: false

      t.timestamps
    end
  end
end
