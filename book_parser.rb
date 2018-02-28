module BookParser
  class Author
    attr_accessor :first_name, :last_name

    def initialize(first_name, last_name)
      @first_name = first_name
      @last_name = last_name
    end
  end

  class Book
    attr_accessor :title, :author

    def initialize(title, author)
      @title = title
      @author = author
    end
  end

  def fetch_books(args)
    return puts "Please provide a file name." unless args[0]
    BookParser.parse_books(File.readlines(args[0]))
  end

  def clean(line)
    line.split(' ')
        .reverse[1..-1]
        .reverse
        .join(' ')
  end

  def optional(value)
    return nil unless value && value.is_a?(String)
    value.strip.size > 0 ? value : nil
  end

  def parse_book(line)
    return nil unless line
    title_author = line.split(" by ").map(&:strip)
    return nil unless title_author &&
                      title_author.first && title_author.last
    title        = title_author.first
    author       = title_author.last.split(' ')
    last_name    = author.last
    first_name   = author.join(' ')
                         .sub(/#{last_name}/, '')
                         .strip
    Book.new(title, Author.new(first_name, last_name))
  end

  def parse_books(lines)
    lines.map    { |line| clean(line) }
         .reject { |line| line.nil? }
         .map    { |line| parse_book(line) }
  end

  def format_author(author)
    [author.last_name, optional(author.first_name)]
      .compact.join(', ')
  end
end
