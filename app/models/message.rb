class Message < ApplicationRecord
  has_paper_trail

  belongs_to :channel
  has_one :author # User の STI
  has_many :mentions # User の STI
  has_many :attachments
  has_many :embeds
  has_many :reactions
end
