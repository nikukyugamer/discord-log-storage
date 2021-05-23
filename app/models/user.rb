class User < ApplicationRecord
  has_paper_trail

  has_many :messages

  # TODO: バリデーション
end
