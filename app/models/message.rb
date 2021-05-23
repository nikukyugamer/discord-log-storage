class Message < ApplicationRecord
  has_paper_trail

  belongs_to :channel
  belongs_to :user # author と mentions の場合がある
  has_many :attachments
  has_many :embeds
  has_many :reactions

  # TODO: バリデーション

  delegate :guild, to: :channel

  def single_message_url
    "https://discord.com/channels/#{guild.id_number}/#{channel.id_number}/#{id_number}"
  end
end
