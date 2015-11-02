module Jekyll
  class CategoryPage < Page
    def initialize(site, base, dir, category)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(@base, '_layouts'), 'category_index.html')
      self.data['category'] = category
      self.data['title'] = page_title(category)
      self.data['posts'] = []

      site.posts.docs.each do |post|
        self.data['posts'] << post if post.data["categories"].include? category
      end

      self.data['posts'].reverse!
    end

    def page_title(category)
      category_title_prefix = @site.config['category_title_prefix'] || 'Category: '
     "#{category_title_prefix}#{category}" 
    end
  end

  class CategoryPageGenerator < Generator
    safe true
    
    def generate(site)
      if site.layouts.key? 'category_index'
        dir = site.config['category_dir'] || 'categories'
        site.categories.keys.each do |category|
          cat_dir = File.join(dir, category) 
          site.pages << CategoryPage.new(site, site.source, cat_dir, category)
        end
      end
    end
  end
end
