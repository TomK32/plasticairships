require File.dirname(__FILE__) + '/../test_helper'
require_dependency 'sites_controller'

class SitesControllerTest < ActionController::TestCase
  
  def setup
    @controller = SitesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_01_add_site_as_guest
    sites_counter = Site.count
    get :new
    # no (guest) user yet
    assert_equal false, @controller.current_user
    
    # no success with this incomplete one
    post :create, {:title => 'my website'}
    # with the creation of guest users we are not being redirected
    assert_equal false, @response.redirect?
    assert @controller.current_user.guest?
    guest_user = @controller.current_user
    assert_equal false, flash.empty?

    # and now successfully
    post :create, :site => {:title => 'my website',
      :url => 'http://tomk32.de',
      :description => 'This is my website and it\'s pretty awesome. Have a look at it.',
      :published => true,
      :tag_list => 'tomk32,blog,germany'}
    puts assigns['site'].errors.full_messages
    assert_equal sites_counter+1, Site.count
    assert_equal sites_counter, Site.published.count
    assert_not_nil assigns['site']
    site = assigns['site']
    assert_equal false, site.new_record?
    assert_equal false, site.published?
    assert_equal %w(tomk32 blog germany), site.tag_list
    assert_equal guest_user, @controller.current_user
  end
end
