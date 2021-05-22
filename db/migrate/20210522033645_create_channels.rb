class CreateChannels < ActiveRecord::Migration[6.1]
  def change
    create_table :channels do |t|
      t.integer :id_number
      t.string :type_name
      t.string :category
      t.string :name
      t.string :topic

      t.references :guild

      t.timestamps
    end

    add_index :channels, :id_number, unique: true
  end
end
