class Embed < ApplicationRecord
  has_paper_trail

  belongs_to :message

  # rubocop:disable Security/Eval
  def hash_in_array_fields
    # TODO: eval なので念のためチェックを入れたい
    fields.map { |field| eval(field) }
  end
  # rubocop:enable Security/Eval
end
