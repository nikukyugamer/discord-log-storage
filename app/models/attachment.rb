class Attachment < ApplicationRecord
  has_paper_trail

  belongs_to :message
end
