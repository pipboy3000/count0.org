require 'pry'

module Jekyll
  class ArchivePage < Page
    def initialize(site, base, dir)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(@base, '_layouts'), 'archive_index.html')
      self.data['title'] = 'Archives'
      self.data['archives'] = []
      self.data['archives'] = site.posts.docs.group_by { |post| post.date.year }
    end        
  end

  class ArchivePageGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key? 'archive_index'
        dir = site.config['archive_dir'] || 'archives'
        site.pages << ArchivePage.new(site, site.source, dir)
      end
    end
  end
end
