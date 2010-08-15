require 'rake/gempackagetask'
require 'rubygems/specification'
require 'bundler'
require 'date'
require 'spec/rake/spectask'

spec = Gem::Specification.new do |s|
  s.name = "http-pulse"
  s.version = "0.0.3"
  s.author = "Corey Donohoe"
  s.email = "atmos@atmos.org"
  s.homepage = "http://www.atmos.org/http-pulse"
  s.description = s.summary = "A gem that provides interaction with the http-pulse service"

  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["README.md", "LICENSE.md"]
  s.summary = "A CLI tools for http-pulse"

  bundle = Bundler::Definition.from_gemfile('Gemfile')
  bundle.dependencies.each do |dep|
    next unless dep.groups.include?(:runtime)
    s.add_dependency(dep.name, dep.version_requirements.to_s)
  end

  s.bindir       = "bin"
  s.executables  = %w( http-pulse )

  s.require_path = 'lib'
  s.files = %w(LICENSE.md README.md Rakefile) + Dir.glob("{bin,lib}/**/*")
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

task :default => :spec

desc "Run specs"
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = %w(-fs --color)
end
