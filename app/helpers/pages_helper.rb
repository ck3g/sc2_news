module PagesHelper
  def page_enabled_class(page)
    page.enabled? ? 'success' : 'error'
  end
end
