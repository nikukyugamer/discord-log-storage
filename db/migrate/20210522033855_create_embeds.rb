class CreateEmbeds < ActiveRecord::Migration[6.1]
  def change
    create_table :embeds do |t|
      t.string :title
      t.string :url
      t.datetime :timestamp
      t.string :description
      t.string :color
      t.jsonb :author
      t.jsonb :image
      t.jsonb :footer
      t.jsonb :thumbnail
      t.string :fields, array: true # PostgreSQL のみ
      t.references :message

      t.timestamps
    end
  end
end
