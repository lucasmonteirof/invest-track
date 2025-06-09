require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @user.date_of_birth = Date.new(2010, 6, 15)
    travel_to Date.new(2020, 6, 15)
  end

  test "age method" do
    assert @user.age == 10
  end

  test "age method when 1 year before birthday" do
    travel -1.year do
      assert @user.age == 9
    end
  end

  test "age method when 1 year after birthday" do
    travel 1.year do
      assert @user.age == 11
    end
  end

  test "age method when 1 month before birthday" do
    travel -1.month do
      assert @user.age == 9
    end
  end

  test "age method when 1 month after birthday" do
    travel 1.month do
      assert @user.age == 10
    end
  end

  test "age method when 1 day before birthday" do
    travel -1.day do
      assert @user.age == 9
    end
  end

  test "age method when 1 day after birthday" do
    travel 1.day do
      assert @user.age == 10
    end
  end
end
