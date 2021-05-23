require 'rails_helper'

RSpec.describe Importer do
  describe '#guild_list' do
    let(:guild_list_response) { File.read(Rails.root.join('spec/responses/guilds.txt')) }

    describe 'upsert: true' do
      example '全てのレコードが INSERT のときに実行が成功すること' do
        result = Importer.guild_list(guild_list_response, upsert: true)

        expect(result).to eq guild_list_response
        expect(Guild.count).to eq 9
      end

      example '全てのレコードが UPDATE のときに実行が成功すること' do
        Importer.guild_list(guild_list_response, upsert: true)
        all_records_updated_at = Guild.all.pluck(:updated_at).dup

        guilds_for_all_update = File.read(Rails.root.join('spec/responses/factories/guilds_for_all_update.txt'))
        result = Importer.guild_list(guilds_for_all_update, upsert: true)

        expect(result).not_to eq guild_list_response
        expect(Guild.count).to eq 9
        expect(all_records_updated_at).not_to eq Guild.all.pluck(:updated_at)
      end

      example 'INSERT と UPDATE のレコードが混在しているときに実行が成功すること' do
        Importer.guild_list(guild_list_response, upsert: true)
        all_records_updated_at = Guild.all.pluck(:updated_at).dup

        guilds_for_insert_and_update = File.read(Rails.root.join('spec/responses/factories/guilds_for_insert_and_update.txt'))
        result = Importer.guild_list(guilds_for_insert_and_update, upsert: true)

        expect(result).not_to eq guild_list_response
        expect(Guild.count).to eq 10
        expect(all_records_updated_at).not_to eq Guild.all.pluck(:updated_at)
      end

      example '更新がないときに実行が成功すること' do
        Importer.guild_list(guild_list_response, upsert: true)
        all_records_updated_at = Guild.all.pluck(:updated_at).dup
        result = Importer.guild_list(guild_list_response, upsert: true)

        expect(result).to eq guild_list_response
        expect(Guild.count).to eq 9
        expect(all_records_updated_at).to eq Guild.all.pluck(:updated_at)
      end
    end

    describe 'upsert: false' do
      example do
        result = Importer.guild_list(guild_list_response, upsert: true)

        expect(result).to eq guild_list_response
      end
    end
  end
end
