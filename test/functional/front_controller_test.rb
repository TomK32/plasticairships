require File.dirname(__FILE__) + '/../test_helper'

class FrontControllerTest < ActionController::TestCase
  def setup
    @controller = FrontController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_01_index
    get :index
    assert assigns['posts']
    assert assigns['site_comments']
    assert assigns['post_comments']
  end
end
