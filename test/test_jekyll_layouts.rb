require 'helper'

class TestJekyllLayouts < Minitest::Test
  include LayoutsTestHelpers

  def setup
    @site = fixture_site
    @site.read
    @generator = Jekyll::LayoutsGenerator.new(@site.config)
  end

  should "render json layout for page" do
    page = page_with_name(@site, "index.md")

    @generator.render_page @site, page, "json-layout"
    assert_equal page.output, "{\"title\":\"I'm a page\",\"layout\":\"json-layout\",\"content\":\"test test test\",\"dir\":\"/\",\"name\":\"index.md\",\"path\":\"index.md\",\"url\":\"/index.html\"}"
  end

  context "reading static config setting" do
    def setup
      @generator = Jekyll::LayoutsGenerator.new(Hash.new)
    end

    should "handle a raw string" do
      assert_equal true, @generator.config_static("static")
      assert_equal false, @generator.config_static("none")
    end

    should "handle a hash config" do
      assert_equal true, @generator.config_static({"static" => true})
      assert_equal false, @generator.config_static({"static" => false})
    end

    should "default to false if empty" do
      assert_equal false, @generator.config_static({})
    end

    should "default to false if not there" do
      assert_equal false, @generator.config_static(nil)
    end
  end

end
