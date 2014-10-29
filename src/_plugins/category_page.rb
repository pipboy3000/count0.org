module Jekyll
  class CategoryPage < Page
    def initialize(site, base, dir, category)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'category_index.html')

      self.data['category'] = category
      self.data['title'] = page_title(category)

      self.data['posts'] = []
      post_base = File.join(base, '_posts')
      Dir.glob(post_base + "/*").each do |post_file|
        post = Post.new(site, base, '', File.basename(post_file))
        if post.categories.include? category
          self.data['posts'] << post
        end
      end

      self.data['posts'].reverse!
    end

    def page_title(category)
      category_title_prefix = site.config['category_title_prefix'] || 'Category: '
     "#{category_title_prefix}#{category}" 
    end
  end

  class CategoryPageGenerator < Generator
    safe true
    
    def generate(site)
      if site.layouts.key? 'category_index'
        dir = site.config['category_dir'] || 'categories'
        site.categories.keys.each do |category|
          site.pages << CategoryPage.new(site, site.source, File.join(dir, category), category)
        end
      end
    end
  end
end
