require 'rails_helper'

RSpec.describe Executor do
  describe '#merged_options' do
    describe 'options の値が' do
      # TODO: app/lib/executor.rb#merged_options で定義されている値が変更されるとこちらも変える必要があり、DRY でない
      let(:default_options) {
        {
          output_directory: 'tmp/executor_output_temporary_for_saving_to_database.json',
          output_format: 'Json'
        }
      }

      example '{} のときは デフォルトのオプション値 がそのまま返ってくること' do
        expect(Executor.merged_options({})).to eq default_options
      end

      example "{ foo: 'bar' } のときは デフォルトのオプション値 がそのまま返ってくること" do
        expect(Executor.merged_options({ foo: 'bar' })).to eq default_options
      end

      example '{ channel_id: 12345 } のときは デフォルトのオプション値 + 与えたオプション が返ってくること' do
        expect(Executor.merged_options({ channel_id: 12345 })).to eq (
          {
            output_directory: 'tmp/executor_output_temporary_for_saving_to_database.json',
            output_format: 'Json',
            channel_id: 12345
          }
        )
      end
    end
  end
end
