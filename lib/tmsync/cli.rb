require "thor"
require "tmsync"

module Tmsync
  class CLI < Thor
    desc "execute", "Runs a given command for all localizable files in all found languages"
    option :path, required: true, type: :string, aliases: :p
    option :command, required: true, type: :string, aliases: :cmd, desc: '<LANGUAGE> and <FILE_PATH> will be replaced'
    option :platform, default: 'custom', type: :string
    option :matching_regex, type: :string, aliases: :matching
    option :exclude_regex, type: :string, aliases: :exclude
    def execute
      matching_regex = -> {
        case options[:platform].downcase
        when 'ios'
          Tmsync::Constants::IOS_MATCHING_REGEX
        when 'android'
          Tmsync::Constants::ANDROID_MATCHING_REGEX
        else
          options[:matching_regex]
        end
      }.call

      exclude_regex = -> {
        case options[:platform].downcase
        when 'ios'
          Tmsync::Constants::IOS_EXCLUDE_REGEX
        when 'android'
          Tmsync::Constants::ANDROID_EXCLUDE_REGEX
        else
          options[:exclude_regex]
        end
      }.call

      file_search = Tmsync::FileSearch.new(
        base_path: options[:path],
        matching_regex: matching_regex,
        exclude_regex: exclude_regex
      )

      result = file_search.find_all_grouped_by_language

      if result.empty?
        puts "No translation files found."
      else
        result.keys.each do |language|
          result[language].each do |file_path|
            file_directory = File.dirname(file_path)
            file_extension = File.extname(file_path)
            file_name = File.basename(file_path, file_extension)

            command = options[:command]
              .gsub('<LANGUAGE>', language)
              .gsub('<FILE_PATH>', file_path)
              .gsub('<FILE_DIR>', file_directory)
              .gsub('<FILE_EXT>', file_extension)
              .gsub('<FILE_NAME>', file_name)

            puts "Executing: '#{command}'"
            output = %x(#{command})

            if output.nil? || output.empty?
              puts "Output: n/a"
            else
              puts "Output: #{output}"
            end
          end
        end
      end
    end
  end
end
