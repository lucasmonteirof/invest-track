require "test_helper"
require "minitest/mock"

class UserTest < ActiveSupport::TestCase
  test "age method" do
    @user = users(:one)
    mock = Minitest::Mock.new
    mock.expect(:today, Date.new(2025, 6, 5))

    Date.stub :today, mock.today do
      puts @user.age
      assert @user.age == 30
    end
  end
end
