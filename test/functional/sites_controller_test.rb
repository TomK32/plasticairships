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
    post :create
    assert_not_nil assigns['site']
    site = assigns['site']
    # check for the correct error messages
    assert site.errors.on(:title)
    assert site.errors.on(:url)
    assert site.errors.on(:permalink)
    assert site.errors.on(:description)
    assert @controller.current_user.guest?
    guest_user = @controller.current_user
    assert_equal false, flash.empty?

    # and now successfully
    post :create, :site => {:title => 'my website',
      :url => 'http://tomk32.de',
      :description => 'This is my website and it\'s pretty awesome. Have a look at it.',
      :published => true,
      :tag_list => 'tomk32,blog,germany'}
    # we are not redirected to prevent cached flash messages
    assert_equal false, @response.redirect?
    assert_not_nil assigns['site']
    site = assigns['site']
    
    # no errors of course
    assert site.errors.empty?

    # site must be saved and not published as it's a guest user
    assert_equal sites_counter+1, Site.count
    assert_equal sites_counter, Site.published.count
    assert_equal false, site.new_record?
    assert_equal false, site.published?
    assert_equal %w(blog germany tomk32), site.tag_list.sort
    
    # it must be the same guest user, otherwise we spam the user table
    assert_equal guest_user, @controller.current_user
  end
end
