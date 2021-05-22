class CreateEmbeds < ActiveRecord::Migration[6.1]
  def change
    create_table :embeds do |t|
      t.string :title
      t.string :url
      t.datetime :timestamp
      t.string :description
      t.jsonb :thumbnail
      t.string :fields # レスポンスは Array だが、レスポンス例が分からないのでとりあえず String 型で格納する

      t.references :message

      t.timestamps
    end
  end
end
