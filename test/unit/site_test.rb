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

  # a before_validation filter sets the permalink automatically
  def test_02_permalinks
    site = Site.find 1
    assert_equal site.title, 'example'
    site.permalink = nil
    site.save!
    assert_equal site.permalink, PermalinkFu.escape(site.url_short)
    site.permalink = 'example'
    site.save!
    assert_not_equal site.permalink, PermalinkFu.escape(site.url_short)
  end
  
  def test_03_thumbnail_filename
    site = Site.find 1, :include => :assets
    assert_nil site.thumbnail_filename
    assert_equal 'image1.jpg', site.screenshot.filename
    site.save!
    assert_equal "/site_assets/%.4d/%.4d/image1_thumb.jpg" % [site.screenshot.id/1000, site.screenshot.id%1000], site.thumbnail_filename
  end
  
  def test_04_short_url
    site = Site.find 1
    assert_equal 'example.com', site.url_short
  end
end
