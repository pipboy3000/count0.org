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
        return ArchivePagination.first_page_url(site) if num_page <= 1
        format = site.config['archive_paginate_path'] || 'archive/page:num'
        format = format.sub(':num', num_page.to_s)
        ensure_leading_slash(format)
      end

      def self.pagination_candidate?(config, page)
        page_dir = File.dirname(File.expand_path(remove_leading_slash(page.path), config['source']))
        paginate_path = remove_leading_slash(config['archive_paginate_path'] || 'archive/page:num')
        paginate_path = File.expand_path(paginate_path, config['source'])
        page.name == 'index.html' &&
          in_hierarchy(config['source'], page_dir, File.dirname(paginate_path))
      end
    end

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
