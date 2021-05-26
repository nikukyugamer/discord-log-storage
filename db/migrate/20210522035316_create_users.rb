class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.bigint :id_number
      t.string :name
      t.boolean :is_bot
      t.string :discriminator
      t.string :nickname
      t.string :avatar_url

      t.timestamps
    end

    add_index :users, :id_number, unique: true
  end
end
