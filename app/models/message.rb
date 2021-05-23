class Message < ApplicationRecord
  has_paper_trail

  belongs_to :channel
  belongs_to :user # author と mentions の場合がある
  has_many :attachments
  has_many :embeds
  has_many :reactions

  # TODO: バリデーション
end
