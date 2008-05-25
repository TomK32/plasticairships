class SiteCommentSweeper < ActionController::Caching::Sweeper
  observe SiteComment
    
  def after_save(record)
#    return unless record.published?
    expire_action(:controller => 'site', :action => 'show', :id => record.site_id)
   end
   alias :after_destroy :after_save
end