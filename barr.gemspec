# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'barr/version'

Gem::Specification.new do |spec|
  spec.name          = "barr"
  spec.version       = Barr::VERSION
  spec.authors       = ["Dave Russell"]
  spec.email         = ["dave.kerr@gmail.com"]

  spec.summary       = "Barr is a status line generator for use with Lemonbar"
  spec.homepage      = "https://github.com/OkayDave/barr"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = `git ls-files -- exe/*`.split("\n").map{ |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "timecop", "~> 0.8.0"
  spec.add_development_dependency "pry", "~> 0.10"

  spec.add_runtime_dependency "i3ipc", "0.2.0"
  spec.add_runtime_dependency "weather-api", "1.2.0"
  spec.add_runtime_dependency "nokogiri", "~> 1.6"

  spec.requirements << "Lemonbar with XFT support (https://github.com/krypt-n/bar)"
  spec.requirements << "(Optional) I3 for Workspace support"
  spec.requirements << "(Optional) Bspwm for Bspwm desktop support"
  spec.requirements << "(Optional) RhythmBox & rhythmbox-client"
  spec.requirements << "(Optional) FontAwesome font"
end
