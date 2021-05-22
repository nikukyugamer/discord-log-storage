class CreateGuilds < ActiveRecord::Migration[6.1]
  def change
    create_table :guilds do |t|
      t.bigint :id_number
      t.string :name
      t.string :icon_url

      t.timestamps
    end

    add_index :guilds, :id_number, unique: true
  end
end
