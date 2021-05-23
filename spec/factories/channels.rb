FactoryBot.define do
  factory :channel do
    id_number { 736851523744162090 }
    type_name { 'GuildTextChat' }
    category { 'Text Channels' }
    name { '雑談用チャンネル' }
    topic { '好きなことを話しましょう' }
  end
end
