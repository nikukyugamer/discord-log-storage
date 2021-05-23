class Executor
  class << self
    def draft(target_channel_id)
      file_name = 'tmp/draft.json'
      DiscordChatExporter::Channel.new.export(
        {
          channel_id: target_channel_id,
          output_directory: file_name
        }
      )
      exported_json = JSON.parse(File.read(Rails.root.join(file_name)))
      Importer.exported_data(exported_json)
      File.delete(Rails.root.join(file_name))
    end
  end
end
