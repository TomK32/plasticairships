require File.dirname(__FILE__) + '/../test_helper'
require_dependency 'sites_controller'

class SitesControllerTest < ActionController::TestCase
  
  def setup
    @controller = SitesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_01_add_site_as_guest
    get :new
    post :create, {:title => 'my website'}
  end
end
