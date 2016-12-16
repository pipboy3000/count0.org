---
title: Jekyllでページ分割をしたい
layout: post
categories: ruby jekyll
---
ブログの見た目を変えたついでにアーカイブページを作りました。[以前作ったカテゴリーページ]({% post_url 2013-07-04-jekyll-category-page %})とは違い、ページ分割ができるようにしました。Jekyllでページ分割のページを作りたい場合、gemでJekyllと一緒にインストールされる[jekyll-paginate][jekyll-paginate]を使います。

Jekyll::PaginateモジュールのPagerとPaginatorクラスをベースにArchivePagerとArchivePaginatorクラスを作りました。実装はベースクラスのメソッドを都合に合わせて上書きしました。独自に追加した機能はアーカイブページのパスのフォーマット(例えば/archive/page2)をconfig.ymlで設定できるようにしたことぐらいです。このコードを`SRCDIR/_plugins/archive_page.rb`として設置します。

```ruby
# SRCDIR/_plugins/archive_page.rb
module Jekyll
  module Paginate
    class ArchivePager < Pager
      def initialize(site, page, all_posts, num_pages = nil)
        super(site, page, all_posts, num_pages)
        @previous_page_path = ArchivePager.paginate_path(site, @previous_page)
        @next_page_path = ArchivePager.paginate_path(site, @next_page)
      end        

      def self.paginate_path(site, num_page)
        return nil if num_page.nil?
        # 最初のページの場合の処理
        return ArchivePagination.first_page_url(site) if num_page <= 1
        # 2ページ以降の処理
        # config.ymlにアーカイブページのパス設定があれば使う。
        format = site.config['archive_paginate_path'] || 'archive/page:num'
        format = format.sub(':num', num_page.to_s)
        ensure_leading_slash(format)
      end

      def self.pagination_candidate?(config, page)
        page_dir = File.dirname(File.expand_path(remove_leading_slash(page.path), config['source']))
        # config.ymlにアーカイブページのパス設定があれば使う。
        paginate_path = remove_leading_slash(config['archive_paginate_path'] || 'archive/page:num')
        paginate_path = File.expand_path(paginate_path, config['source'])
        page.name == 'index.html' &&
          in_hierarchy(config['source'], page_dir, File.dirname(paginate_path))
      end
    end

    # Pagerクラスを呼び出している部分をArchivePagerに書き換え
    class ArchivePagination < Pagination
      def generate(site)
        if ArchivePager.pagination_enabled?(site)
          if template = template_page(site)
            paginate(site, template)
          else
            Jekyll.logger.warn "Pagination:", "Pagination is enabled, but I couldn't find " +
            "an index.html page to use as the pagination template. Skipping pagination."
          end
        end
      end

      def paginate(site, page)
        all_posts = site.site_payload['site']['posts']
        pages = ArchivePager.calculate_pages(all_posts, site.config['paginate'].to_i)
        (1..pages).each do |num_page|
          pager = ArchivePager.new(site, num_page, all_posts, pages)
          if num_page > 1
            newpage = Page.new(site, site.source, page.dir, page.name)
            newpage.pager = pager
            newpage.dir = ArchivePager.paginate_path(site, num_page)
            site.pages << newpage
          else
            page.pager = pager
          end
        end
      end

      def self.first_page_url(site)
        if page = ArchivePagination.new.template_page(site)
          page.url
        else
          nil
        end
      end

      def template_page(site)
        site.pages.dup.select do |page|
          ArchivePager.pagination_candidate?(site.config, page)
        end.sort do |one, two|
          two.path.size <=> one.path.size
        end.first
      end
    end
  end
end
```

テンプレートは`SRCDIR/archive/index.html`に設置します。使える変数は`paginator`を筆頭に[公式のドキュメント][jekyll-pagination-doc]と同じです。

``` slim
{% raw %}
---
layout: default
title: Archive
---
<h1 class="page-title">Archive</h1>

<div class="paginator">
  {% if paginator.previous_page_path %}
  <a href="{{paginator.previous_page_path}}" class="button">PREV</a>
  {% else %}
  <a href="/" class="button">HOME</a>
  {% endif %}
  <div class="paginator-info">{{paginator.page}} / {{paginator.total_pages}}</div>
  {% if paginator.next_page_path %}
  <a href="{{paginator.next_page_path}}" class="button">NEXT</a>
  {% endif %}
</div>

<div class="articleList">
  {% for post in paginator.posts %}
  <div class="articleList-item">
    <div class="articleList-item-title"><a href="{{ post.url }}">{{ post.title }}</a></div>
    <div class="articleList-item-date">{{ post.date | date_to_long_string }}</div>
    {% for category in post.categories %}
    <a href="/categories/{{category}}" class="articleList-item-category">{{ category }}</a>
    {% endfor %}
    <div class="articleList-item-text">
      {{ post.content | strip_html | xml_escape | truncate: 90 }}
    </div>
  </div>
  {% endfor %}
</div>

<div class="paginator">
  {% if paginator.previous_page_path %}
  <a href="{{paginator.previous_page_path}}" class="button">PREV</a>
  {% else %}
  <a href="/" class="button">HOME</a>
  {% endif %}
  <div class="paginator-info">{{paginator.page}} / {{paginator.total_pages}}</div>
  {% if paginator.next_page_path %}
  <a href="{{paginator.next_page_path}}" class="button">NEXT</a>
  {% endif %}
</div>
{% endraw %}
```

こういった基本的な機能を実装するたびにwordpressでいいのではないかと迷うけど、wordpressだとAWSのS3で運用できないという、いつもの結論に辿り着きます。しかし、[staticpress][staticpress]というものがあるので、悩みますな。

[jekyll-paginate]: https://github.com/jekyll/jekyll-paginate
[jekyll-pagination-doc]: http://jekyllrb.com/docs/pagination/
[staticpress]: http://ja.staticpress.net/
