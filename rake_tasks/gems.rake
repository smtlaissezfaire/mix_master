begin
  require 'jeweler'
  
  Jeweler::Tasks.new do |gemspec|
    gemspec.name        = "mix_master"
    gemspec.summary     = "Mix and unmix modules"
    gemspec.description = <<-DESC
      Allows modules to be unmixed at runtime from classes,
      much as Mixology or Mixico do.  Implemented in pure ruby with
      no C extensions.
    DESC
    gemspec.email       = "scott@railsnewbie.com"
    gemspec.homepage    = "http://github.com/smtlaissezfaire/mix_master"
    gemspec.authors     = ["Scott Taylor"]
    gemspec.add_dependency "smtlaissezfaire-using", ">= 0.1.5"
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end
