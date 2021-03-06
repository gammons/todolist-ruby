# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'todo-cli/version'

Gem::Specification.new do |spec|
  spec.name          = "todolist"
  spec.version       = Todo::VERSION
  spec.authors       = ["Grant Ammons"]
  spec.email         = ["gammons@gmail.com"]

  spec.summary       = %q{todolist is a simple, GTD-style todo list for the command line.}
  spec.description   = %q{Write a longer description or delete this line.}
  spec.homepage      = "https://github.com/gammons/todolist"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   << "todo"
  spec.require_paths = ["lib"]

  spec.add_dependency "chronic"
  spec.add_dependency "colored"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
