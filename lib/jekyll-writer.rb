require 'jekyll'

module Jekyll
  module LayoutsExtensionWriter
    def destination(dest, pagename = "index.html")
      #self.is_a? Document
      dest = self.site.in_dest_dir(dest)
      # The url needs to be unescaped in order to preserve the correct filename
      path = self.site.in_dest_dir(dest, URL.unescape_path(self.url))
      ext = File.extname(pagename)
      if ext == ".html"
        path = File.join(path, pagename) if self.url.end_with?("/")
        path << self.output_ext unless path.end_with?(self.output_ext)
      else
        path = path + ext # if self.url.end_with?("/")
      end
      path
    end

    def write(dest, pagename = "index.html")
      path = destination(dest, pagename)
      FileUtils.mkdir_p(File.dirname(path))
      File.open(path, 'wb') do |f|
        f.write(self.output)
      end
      Jekyll::Hooks.trigger self, :post_write
    end
  end
end

class Jekyll::Post
  prepend Jekyll::LayoutsExtensionWriter
end

class Jekyll::Document
  prepend Jekyll::LayoutsExtensionWriter
end

class Jekyll::Page
  prepend Jekyll::LayoutsExtensionWriter
end
