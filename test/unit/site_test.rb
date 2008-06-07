require File.dirname(__FILE__) + '/../test_helper'

class SiteTest < ActiveSupport::TestCase

  def test_01_protected_attributes
    site = Site.new(:title => 'example', 
        :url => 'http://example.com', 
        :description => 'Here goes the description of this website.',
        :user_id => 1,
        :published => true,
        :featured => true)
    # won't save as user cannot be mass-asigned
    assert_raise ActiveRecord::RecordInvalid do
      site.save!
    end
    site.user_id = 1
    site.save!
    # those must be false, not true
    assert_equal false, site.published
    assert_equal false, site.featured
  end
  
  # a before_validation filter set the permalink automatically
  def test_02_permalinks
    site = Site.find(1)
    assert_equal site.title, 'example_com'
    assert_nil site.permalink
    site.save!
    assert_equal site.permalink, PermalinkFu.escape(site.title)
    site.permalink = 'example'
    site.save!
    assert_not_equal site.permalink, PermalinkFu.escape(site.title)
  end
end
