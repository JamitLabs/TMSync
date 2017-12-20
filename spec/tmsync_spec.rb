RSpec.describe Tmsync do
  it "has a version number" do
    expect(Tmsync::VERSION).not_to be nil
  end

  it "finds all matching files in ios project" do
    ios_project_base_path = File.join(File.dirname(__FILE__), "example_projects/ios")
    file_search = Tmsync::FileSearch.new(
      base_path: ios_project_base_path,
      matching_regex: Tmsync::Constants::IOS_MATCHING_REGEX,
      exclude_regex: Tmsync::Constants::IOS_EXLUDE_REGEX
    )
    result = file_search.find_all_grouped_by_language

    expect(result.keys).to eq ['de', 'en']
    expect(result['de'].map { |p| p.gsub(ios_project_base_path, '') }).to eq [
      "/Sources/User Interfaces/de.lproj/LaunchScreen.strings",
      "/Sources/User Interfaces/de.lproj/Feedback.strings",
      "/Sources/Supporting Files/de.lproj/Localizable.strings",
      "/Sources/Supporting Files/de.lproj/InfoPlist.strings"
    ]
    expect(result['en'].map { |p| p.gsub(ios_project_base_path, '') }).to eq [
      "/Sources/User Interfaces/en.lproj/LaunchScreen.strings",
      "/Sources/User Interfaces/en.lproj/Feedback.strings",
      "/Sources/Supporting Files/en.lproj/Localizable.strings",
      "/Sources/Supporting Files/en.lproj/InfoPlist.strings"
    ]
  end
end
