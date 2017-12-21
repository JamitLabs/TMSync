
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "tmsync/version"

Gem::Specification.new do |spec|
  spec.name          = "tmsync"
  spec.version       = Tmsync::VERSION
  spec.authors       = ["Cihat Gündüz"]
  spec.email         = ["cihat.guenduez@jamitlabs.com"]

  spec.summary       = %q{Translation Management Synchronization tool for any translation management service & platform.}
  spec.homepage      = "https://github.com/JamitLabs/TMSync"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "thor"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry-byebug"
end
