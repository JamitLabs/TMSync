require "bundler/setup"
require "tmsync"
require "pry-byebug"

RSpec.configure do |config|
  # Exclude tests from example projects
  config.exclude_pattern = "./spec/example_projects/**/*_spec.rb"

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
