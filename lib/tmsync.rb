require "tmsync/version"

module Tmsync
  class Constants
    IOS_MATCHING_REGEX = '.*\/(\S+)\.lproj\/.*\.strings'
    IOS_EXCLUDE_REGEX = '\/Carthage\/|\/Pods\/'

    ANDROID_MATCHING_REGEX = '[^\/]*\/src\/main\/res\/values-?(\S+)?\/strings.xml'
    ANDROID_EXCLUDE_REGEX = '\A\z'

    FALLBACK_LANGUAGE = 'en'
  end
  class FileSearch
    # Initializes a file search object.
    #
    # @param [String] base_path the path of the directory to search within
    # @param [String] matching_regex a regex that all localizable files match, optionally including a catch group for the language
    # @param [String] exclude_regex a regex to exclude some matches from matching_regex
    def initialize(base_path:, matching_regex:, exclude_regex:)
      @base_path = base_path
      @matching_regex = /#{matching_regex}/
      @exclude_regex = /#{exclude_regex}/
    end

    # Finds all files with corresponding language within a given directory
    # matching the specified regexes.
    #
    # @return [Hash] a hash containing language codes as keys and all found files paths as values (so values are of type Array)
    def find_all_grouped_by_language
      all_files = Dir.glob(File.join(@base_path, '**/*'))

      # apply exclude regex
      found_files = all_files.select { |file_path|
        file_path !~ @exclude_regex
      }

      # apply matching regex
      found_files = found_files.select { |file_path|
        file_path =~ @matching_regex
      }.map { |file_path|
        [file_path.match(@matching_regex).captures.first, file_path]
      }

      result = found_files.group_by(&:first).map { |k,v| [k, v.each(&:shift).flatten] }.to_h

      # replace nil key with fallback language
      if !(nil_values = result[nil]).nil?
        result[Tmsync::Constants::FALLBACK_LANGUAGE] = nil_values
        result.delete(nil)
      end

      result
    end
  end
end
