# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def site_title
    @page_title.blank? ? Goldberg.settings.site_name : ('%s // %s' % [@page_title, Goldberg.settings.site_name])
  end
end
