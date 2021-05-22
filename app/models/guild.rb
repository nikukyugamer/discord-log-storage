class Guild < ApplicationRecord
  has_paper_trail

  has_many :channels
end
