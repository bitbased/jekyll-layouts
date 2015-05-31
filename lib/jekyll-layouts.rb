require 'jekyll'
require 'jekyll-writer'
require 'jekyll-cleaner'

module Jekyll
  class LayoutsGenerator < Generator
    safe true
    priority :low

    DEFAULT_CONVERTER = "Default"

    def initialize(config = Hash.new)
      @static = config_static(config['jekyll-layouts'])
    end

    def config_static(configs)
      case configs
      when nil, NilClass
        false
      when String
        configs == "static"
      when Hash
        configs.fetch('static', false)
      else
        raise ArgumentError.new("Your jekyll-layouts config has to either be a string or a hash! It's a #{configs.class} right now.")
      end
    end

    def generate(site)
      @site = site
      site.docs_to_write.each { |doc| process_options doc }
      site.posts.each { |post| process_options post }
      site.pages.each { |page| process_options page }

      site.docs_to_write.each { |doc| render_layouts doc }
      site.posts.each { |post| render_layouts post }
      site.pages.each { |page| render_layouts page }
    end

    def process_options(page)
      return unless page.data.has_key? "layouts"
      # Make sure we are using a clone of the hash to avoid overwriting defaults
      page.data["layouts"] = page.data["layouts"].clone
      page.data["layouts"].each do |extension, options|
        case options
        when nil
          options = { "converter" => "", "suffix" => ".#{extension}" }
        when String
          options = { "layout" => options, "converter" => DEFAULT_CONVERTER, "suffix" => ".#{extension}" }
        end

        if options.is_a? Hash
          options = options.clone
          options['converter'] ||= DEFAULT_CONVERTER
          options['suffix'] ||= ".#{extension}"
          options['url'] ||= page.destination(@site.dest, "index#{options['suffix']}")[@site.dest.length..-1]
        end
        page.data["layouts"][extension] = options
      end
    end

    def render_layouts(page)
      (page.data['layouts'] || []).each do |extension, options|
        pagename = "index#{options['suffix']}"
        case options['converter']
        when DEFAULT_CONVERTER
          render_page(@site, page, options["layout"])
          write_page(page, @site.dest, pagename)
          write_page(page, @site.source, pagename) if @static
        end
      end
    end

    def write_page(page, dest, pagename)
      page.write(dest, pagename)
    end

    def render_page(site, page, layout)
      original_layout = page.data['layout']
      page.data['layout'] = layout
      case page
      when Jekyll::Document
        page.output = Jekyll::Renderer.new(site, page, site.site_payload).run
      when Jekyll::Post, Jekyll::Page
        page.render(site.layouts, site.site_payload)
      end
    ensure
      page.data['layout'] = original_layout
    end

  end
end
