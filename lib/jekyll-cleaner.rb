require 'jekyll'

module Jekyll
  module LayoutsExtensionCleaner
    # Private: Override the list of files to be created when site is built to include additional layouts.
    #
    # Returns a Set with the file paths
    def new_files
      files = Set.new
      site.each_site_file do |item|
        files << item.destination(site.dest)
        # Keep additional extension files
        if item.respond_to? :data and item.data.has_key? "layouts"
          item.data["layouts"].each do |extension, options|
            files << item.destination(site.dest, "index#{options['suffix']}")
          end
        end
      end
      files
    end
  end
end

class Jekyll::Cleaner
  prepend Jekyll::LayoutsExtensionCleaner
end
