class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.bigint :id_number
      t.string :name # , null: false, default: '_NAME_IS_NOTHING_'
      t.boolean :is_bot # , null: false, default: false
      t.string :discriminator # , null: false, default: '_DISCRIMINATOR_IS_NOTHING_' # Mention は Integer で渡ってくる
      t.string :nickname # , null: false, default: '_NICKNAME_IS_NOTHING_'
      t.string :avatar_url # , null: false, default: '_AVATAR_URL_IS_NOTHING_'

      t.timestamps
    end

    add_index :users, :id_number, unique: true
  end
end
