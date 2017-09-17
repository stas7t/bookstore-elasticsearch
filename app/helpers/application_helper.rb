module ApplicationHelper
  def categories
    Category.order('name')
  end
end
