class Channel < ApplicationRecord
  has_paper_trail

  belongs_to :guild
  has_many :messages

  # type_name は enum にできそう
end
