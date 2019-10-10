require 'test_helper'

class BookMarkTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should not save bookmark without title" do
    assert_not BookMark.new(id: 1)
  end

  test "should not save bookmark without id" do
    assert_not BookMark.new(title: "sdfsd")
  end
end
