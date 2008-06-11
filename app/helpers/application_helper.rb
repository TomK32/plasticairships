# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def site_title
    @page_title.blank? ? Goldberg.settings.site_name : ('%s // %s' % [@page_title, Goldberg.settings.site_name])
  end

  def meta_description=(description)
    content_for :meta_description do
      description
    end
  end

  def meta_keywords=(keywords)
    content_for :meta_keywords do
      keywords.join(',')
    end
  end
  
  def content_page(name)
    Goldberg::ContentPage.find_by_name(name)
  end
end
