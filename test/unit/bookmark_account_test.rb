require File.dirname(__FILE__) + '/../test_helper'

class BookmarkAccountTest < ActiveSupport::TestCase

  def test_01_url_generation
    delicious = BookmarkAccount.new(:login => 'TomK32', :tags => 'ruby', :service => 'del.icio.us')
    assert_equal 'http://del.icio.us/rss/TomK32/ruby', delicious.url

    delicious2 = BookmarkAccount.new(:login => 'TomK32', :tags => 'ruby+haiku', :service => 'del.icio.us')
    assert_equal 'http://del.icio.us/rss/TomK32/ruby+haiku', delicious2.url
  end

  def test_02_add_bookmark_account_and_refresh
    user = User.find :first
    user.bookmark_accounts.destroy_all
    bookmark_account = user.bookmark_accounts.create!(:service => 'del.icio.us', :login => 'TomK32', :service => 'del.icio.us')
    user_sites_count = user.sites.count
    new_bookmarks = bookmark_account.refresh
    assert user_sites_count + new_bookmarks.size, user.sites.count
  end
end
