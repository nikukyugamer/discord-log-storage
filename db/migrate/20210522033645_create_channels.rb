class CreateChannels < ActiveRecord::Migration[6.1]
  def change
    create_table :channels do |t|
      t.bigint :id_number
      t.string :type_name
      t.string :category
      t.bigint :category_id_number
      t.string :name
      t.string :topic

      t.references :guild

      t.timestamps
    end

    add_index :channels, :id_number, unique: true
  end
end
