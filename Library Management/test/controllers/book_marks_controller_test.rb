require 'test_helper'

class BookMarksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book_mark = book_marks(:one)
  end

  test "should get index" do
    get book_marks_url
    assert_response :success
  end

  test "should get new" do
    get new_book_mark_url
    assert_response :success
  end

  test "should create book_mark" do
    assert_difference('BookMark.count') do
      post book_marks_url, params: { book_mark: { book_isbn: @book_mark.book_isbn, book_title: @book_mark.book_title, student_email: @book_mark.student_email, student_name: @book_mark.student_name } }
    end

    assert_redirected_to book_mark_url(BookMark.last)
  end

  test "should show book_mark" do
    get book_mark_url(@book_mark)
    assert_response :success
  end

  test "should get edit" do
    get edit_book_mark_url(@book_mark)
    assert_response :success
  end

  test "should update book_mark" do
    patch book_mark_url(@book_mark), params: { book_mark: { book_isbn: @book_mark.book_isbn, book_title: @book_mark.book_title, student_email: @book_mark.student_email, student_name: @book_mark.student_name } }
    assert_redirected_to book_mark_url(@book_mark)
  end

  test "should destroy book_mark" do
    assert_difference('BookMark.count', -1) do
      delete book_mark_url(@book_mark)
    end

    assert_redirected_to book_marks_url
  end
end
