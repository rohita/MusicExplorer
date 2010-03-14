require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test "authenticate" do
    user = User.authenticate("abc@abc.com", "test")
    assert !user.nil?
  end
  
  test "gravatar" do
    assert_equal "http://www.gravatar.com/avatar/4adcca49b3b1e5a08ac202f5d5a9e688?d=monsterid", users(:one).gravatar
  end
  
  
end
