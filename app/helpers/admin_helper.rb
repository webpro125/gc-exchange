module AdminHelper

  def page_title(title)
    content_for :page_title, title
  end

end