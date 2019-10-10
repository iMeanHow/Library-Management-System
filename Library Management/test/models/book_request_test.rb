require 'test_helper'

class BookRequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should not create without isbn" do
    BookRequest.new(email: "sdf")
  end
end
