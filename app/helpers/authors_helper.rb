module AuthorsHelper
  def author_short_description(author)
    return author.description if author.description.length <= 50
    author.description.slice(0, 47).concat('...')
  end
end
