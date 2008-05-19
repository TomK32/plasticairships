require File.dirname(__FILE__) + '/../spec_helper'

context "The PostsController" do
  # fixtures :posts
  controller_name :posts

  specify "should be a PostsController" do
    controller.should_be_an_instance_of PostsController
  end


  specify "should accept GET to index"
    get 'index'
    response.should_be_success
  end

  specify "should have more specifications" do
    violated "not enough specs"
  end
end
