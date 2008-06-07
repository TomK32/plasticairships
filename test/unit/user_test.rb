require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :goldberg_users, :goldberg_roles
  load_goldberg_roles

  def test_01_roles
    assert User.find_by_name('admin').admin?
    assert_equal false, User.find_by_name('moderator').admin?
    assert_equal false, User.find_by_name('member').admin?
    assert_equal false, User.find_by_name('guest').admin?
    
    # moderator role
    assert User.find_by_name('admin').moderator?
    assert User.find_by_name('moderator').moderator?
    assert_equal false, User.find_by_name('member').moderator?
    assert_equal false, User.find_by_name('guest').moderator?
    
    #member
    assert User.find_by_name('admin').member?
    assert User.find_by_name('moderator').member?
    assert User.find_by_name('member').member?
    assert_equal false, User.find_by_name('guest').member?
    
    #guest
    assert User.find_by_name('guest').guest?
  end
end
