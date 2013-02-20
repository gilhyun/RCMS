# encoding: utf-8

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "User MODEL TEST" do
  	u1=users(:u1)
  	assert u1.userid=="zczczc1" , "NOT EQUAL #{u1.userid}"

  	assert_equal u1.userid , "zzzccc1"

  	auser=User.new
  	assert !auser.save 
  end
end
