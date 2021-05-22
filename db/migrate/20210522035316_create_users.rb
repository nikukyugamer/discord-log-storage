class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.bigint :id_number
      t.string :name
      t.boolean :is_bot
      t.string :discriminator # Mention は Integer で渡ってくる
      t.string :nickname # Mention のみ
      t.string :avatar_url # Author のみ

      t.timestamps
    end

    add_index :users, :id_number, unique: true
  end
end
