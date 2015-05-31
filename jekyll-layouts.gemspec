Gem::Specification.new do |spec|
  spec.name        = "jekyll-layouts"
  spec.summary     = "Multiple layouts support for your Jekyll site"
  spec.version     = "0.0.1"
  spec.authors     = ["Brant Wedel"]
  spec.email       = "brant@bitbased.net"

  spec.homepage    = "https://github.com/bitbased/jekyll-layouts"
  spec.licenses    = ["MIT"]
  spec.files       = [ "lib/jekyll-layouts.rb", "lib/jekyll-cleaner.rb", "lib/jekyll-writer.rb" ]

  spec.description   = <<-DESC
    Jekyll plugin, that allows you to output multiple format files with individual layouts for each page, post, or collection.
    DESC

  spec.add_development_dependency "jekyll",       "~> 2.0"
  spec.add_development_dependency  'rake'
  spec.add_development_dependency  'rdoc'
  spec.add_development_dependency  'shoulda'
  spec.add_development_dependency  'minitest'
end
