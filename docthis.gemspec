$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "docthis/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "docthis"
  s.version     = Docthis::VERSION
  s.authors     = ["Andres Arana"]
  s.email       = ["andres.arana@recompensa.mobi"]
  s.homepage    = "https://github.com/recompensa-mobi/docthis"
  s.summary     = "Rails engine to expose your markdown site documentation"
  s.description = "Rails engine which takes your markdown documentation stored in your application repository and exposes that as a wiki-style, navigateable wiki."

  s.files = Dir["{app,config,db,lib}/**/*", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 4.0.5"
  s.add_dependency "pygmentize"
  s.add_dependency "redcarpet"

  s.add_development_dependency "sqlite3"
end
