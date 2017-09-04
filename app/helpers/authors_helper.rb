module AuthorsHelper
  def author_short_description(author, size = 50)
    return author.description if author.description.length <= size
    author.description.slice(0, size - 3).concat('...')
  end

  def author_name(author)
    "#{author.first_name} #{author.last_name}"
  end
end
