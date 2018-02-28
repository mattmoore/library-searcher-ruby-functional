require_relative 'book_parser'
include BookParser

books = BookParser.fetch_books(ARGV)

def top15DistinctAuthorsByName(books)
  books.map(&:author)
       .uniq { |author| [author.first_name, author.last_name] }
       .sort_by { |author| [author.last_name, author.first_name] }
       .take(15)
       .map { |author| format_author(author) }
       .join("\n")
end

puts top15DistinctAuthorsByName(books)
