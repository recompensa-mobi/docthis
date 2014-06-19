# Page model, in charge of discovering and rendering markdown documents into
# wiki pages.
class Docthis::Page

  # Initializes a new instance
  #
  # Params:
  # * options: Hash containing initialization options. May contain any of the following keys:
  #     * `:file`: File to be rendered by this page
  def initialize(options )
    @file = options[:file]
  end

  # Renders the body of this page, returning the resulting HTML document.
  #
  # Returns:
  #   The rendered HTML body of the page
  def body
    @body = nil if Rails.env.development?
    @body ||= render_body
  end

  # Checks to see if the page has any children subpages.
  #
  # Returns:
  #   `true` if it has children, false otherwise.
  def has_children?
    File.basename(@file) == "index.md"
  end

  # Obtains the children subpages of this page.
  #
  # Returns:
  #   Array containing the children subpages of this page. It can be an empty
  #   array, if this page does not have any children
  def children
    @children = nil if Rails.env.development?
    @children ||= !has_children? ? [] : Dir.
      glob(File.join(File.dirname(@file), "*")).
      reject {|f| File.basename(f) == "index.md"}.
      sort.
      map {|f| Docthis::Page.load_page_from_file!(f)}
  end

  # Obtains the id of this page.
  #
  # Returns:
  #   Id to this page.
  def id
    @file.gsub("#{Docthis::Page.base_dir}/", "").gsub(".md", "")
  end

  # Obtains the title of this page.
  def title
    if has_children?
      File.basename(File.dirname(@file)).gsub("-", " ").capitalize
    else
      File.basename(@file).gsub("-", " ").sub(".md", "").capitalize
    end
  end

  # Lookups a page given it's id. The id of a page is the relative path from
  # the docs folder to the corresponding markdown file. It may be a folder; in
  # that case the index file inside that folder is used instead. The markdown
  # extension may or may not be provided in the id.
  #
  # Params:
  #   * id: Id of the page to load. relative path from the docs folder to the
  #   corresponding markdown file. It may be a folder; in that case the index
  #   file inside that folder is used instead. The markdown extension may or
  #   may not be provided in the id. If there is no file with the given id in
  #   the docs folder, an exception will be raised.
  #
  # Returns:
  #   Loaded page given it's id.
  #
  def self.find(id)
    @file_list = nil if Rails.env.development?
    @file_list ||= Dir.glob(File.join(base_dir, "**", "*"))

    @file_set = nil if Rails.env.development?
    @file_set ||= @file_list.inject({}) {|memo, item| memo[item] = true; memo}

    id ||= "/index.md"
    id = File.join(base_dir, id)

    if @file_set.has_key?(id)
      load_page_from_file!(id)
    elsif @file_set.has_key?("#{id}.md")
      load_page_from_file!("#{id}.md")
    else
      raise "Invalid documentation page file #{id}"
    end
  end

  # Loads all the pages from the docs folder.
  #
  # Returns:
  #   Array containing all the pages from the docs folder.
  def self.all
    @all = nil if Rails.env.development?
    @all ||= Dir.
      glob("#{base_dir}/*").
      reject{|f| File.basename(f) == "index.md"}.
      sort.
      map {|f| load_page_from_file!(f)}
  end

  # Obtains the base directory in where the documentation is found.
  #
  # Returns:
  #   The base directory in where the documentation files are found.
  def self.base_dir
    File.join(Rails.root, Docthis.docs_folder)
  end

  protected
  # Loads a page instance for a given file.
  #
  # Returns:
  #   The loaded page instance.
  def self.load_page_from_file!(file)
    file = File.join(file, "index.md") if File.directory?(file)
    Docthis::Page.new(file: file)
  end

  # Renders the body of the page.
  #
  # Returns:
  #   The rendered HTML of the body.
  def render_body
    @@markdown ||= ::Redcarpet::Markdown.new(
      Docthis::Renderer,
      autolink: true,
      fenced_code_blocks: true)

    @@markdown.render(File.read(@file))
  end
end
