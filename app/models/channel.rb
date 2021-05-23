class Channel < ApplicationRecord
  has_paper_trail

  # チャンネルリスト単体でインポートする場合には guild_id が入らない
  belongs_to :guild, optional: true
  has_many :messages

  # type_name は enum にできそう
end
