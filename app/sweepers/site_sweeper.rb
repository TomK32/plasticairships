class SiteSweeper < ActionController::Caching::Sweeper
  observe Site
    
  def after_save(record)
#    return unless record.published?
    expire_action(:controller => 'sites', :action => 'index')
    expire_action(:controller => 'sites', :action => 'show', :id => record.id)
    expire_fragment('sites-sidebar')
   end
   alias :after_destroy :after_save
end