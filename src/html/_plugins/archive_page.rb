module Jekyll
  class ArchivePage < Page
    def initialize(site, base, dir, name = nil, layout = nil)
      @site   = site
      @base   = base
      @dir    = dir
      @name   = name || 'index.html'
      @layout = layout || 'archive_index.html'

      self.process(@name)
      self.read_yaml(File.join(@base, '_layouts'), @layout)
      self.data['title'] = 'Archives'
      self.data['archives'] = []
      posts = @site.posts.docs.reverse
      self.data['archives'] = posts.group_by { |post| post.date.year }
    end        
  end

  class ArchiveJson < ArchivePage
    def initialize(site, base, dir)
      super(site, base, dir, 'index.json', 'archive_index.json')
    end
  end

  class ArchivePageGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key? 'archive_index'
        dir = site.config['archive_dir'] || 'archives'
        site.pages << ArchivePage.new(site, site.source, dir)
        # site.pages << ArchiveJson.new(site, site.source, dir)
      end
    end
  end
end
