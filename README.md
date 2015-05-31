# Jekyll Layouts

Multiple layouts support for your Jekyll site, output multiple format files with individual layouts for each page, post, or collection.

## Usage

Add the following to your site's `Gemfile`

```
gem 'jekyll-layouts'
```

And add the following to your site's `_config.yml`

```yml
gems:
  - jekyll-layouts
```

In any page, post, or collection, use `layouts` and a `extension: layout` value, e.g.

```markdown
---
layouts:
  json: json-post-layout
  md: markdown-post-layout
---
```

**Note**: Jekyll Layouts creates additional pages using the provided extensions and layouts, it does not modify the original page.

## Configuration

Add the following to your yaml front-matter configuration:

```yaml
---
layouts:
  json:
    layout: json-post-layout
    converter: Default
  md:
    layout: markdown-post-layout
    converter: Default
  pdf:
    converter: PhantomPDF
---
```

If you are using the default liquid converter, you can use this shorthand:

```yaml
---
layouts:
  json: json-post-layout
  md: markdown-post-layout
---
```

An example of using a markdown filter for all posts using jekyll-layouts:

```yaml
gems:
  - jekyll-layouts

defaults:
  - scope:
      path: ""
      type: posts
    values:
      layouts:
        json: json-post-layout
        md: markdown-post-layout
```

_layouts/markdown-post-layout.md
```markdown
# {{ page.title }}

Published: {{ page.date }}
Author: {{ page.author }}
Source: {{ page.layouts.md.url }}

---

{{ content | strip_html }}
```

_layouts/json-post-layout.json
```
{{ page | jsonify }}
```

Your posts will now have markdown and json format endpoints using separate layouts.
