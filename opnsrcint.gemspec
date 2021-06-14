# frozen_string_literal: true

require_relative "lib/opnsrcint/version"

Gem::Specification.new do |spec|
  spec.name          = "opnsrcint"
  spec.version       = Opnsrcint::VERSION
  spec.authors       = ["Madhava-mng"]
  spec.email         = ["newmob@hotmail.com"]

  spec.summary       = "OSINT tool"
  spec.description   = "OSINT tool for username,.."
  spec.homepage      = "https://github.com/Madhava-mng/opnsrcint"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["allowed_push_host"] = "https://github.com/Madhava-mng/opnsrcint/opnsrcint-0.1.0.gem"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Madhava-mng/opnsrcint/opnsrcint-0.1.0.gem"
  spec.metadata["changelog_uri"] = "https://github.com/Madhava-mng/opnsrcint/README.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  #spec.files = Dir.chdir(File.expand_path(__dir__)) do
  #  `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  #end
  #spec.bindir        = ""
  spec.require_path = %w{lib}
  spec.files = [
    "Gemfile",                                                                              "lib/opnsrcint.rb",                                                                     "lib/opnsrcint/version.rb",                                                             "lib/opnsrcint/user.rb",                                                                "lib/opnsrcint/script.rb",                                                              "lib/opnsrcint/site.rb",
    "opnsrcint.gemspec",                                                                    "Rakefile",
    "README.md",                                                                            "bin/console",
    "bin/setup",                                                                            "bin/opnsrcint",
  ]

  spec.executables   = ['opnsrcint']
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
