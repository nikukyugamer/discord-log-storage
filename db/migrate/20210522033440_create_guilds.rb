class CreateGuilds < ActiveRecord::Migration[6.1]
  def change
    create_table :guilds do |t|
      t.bigint :id_number, null: false
      t.string :name, null: false, default: '_NAME_IS_NOTHING_'
      t.string :icon_url, null: false, default: '_ICON_URL_IS_NOTHING_'

      t.timestamps
    end

    add_index :guilds, :id_number, unique: true
  end
end
