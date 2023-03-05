require_relative 'lib/ruby_warrior_web/version'

Gem::Specification.new do |spec|
  spec.name          = "ruby_warrior_web"
  spec.version       = RubyWarriorWeb::VERSION
  spec.authors       = ["Yvan BARTH\xC3\x89LEMY"]
  spec.email         = ["223016+ybart@users.noreply.github.com"]

  spec.summary       = %q{Web version of iconic RubyWarrior game}
  spec.homepage      = "https://ybart.github.io/ruby_warrior_web"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ybart/ruby_warrior_web"
  spec.metadata["changelog_uri"] = "https://github.com/ybart/ruby_warrior_web/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
