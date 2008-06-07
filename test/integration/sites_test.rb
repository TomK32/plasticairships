require File.dirname(__FILE__) + '/../test_helper'

class SitesTest < ActionController::IntegrationTest
  fixtures :all

  # we are using to_param in Site
  def test_01_permalink
    assert_equal '/sites/1-example-com', site_path(Site.find(1))
  end

end
