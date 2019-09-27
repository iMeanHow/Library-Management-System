require 'test_helper'

class BookSearchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book_search = book_searches(:one)
  end

  test "should get index" do
    get book_searches_url
    assert_response :success
  end

  test "should get new" do
    get new_book_search_url
    assert_response :success
  end

  test "should create book_search" do
    assert_difference('BookSearch.count') do
      post book_searches_url, params: { book_search: {  } }
    end

    assert_redirected_to book_search_url(BookSearch.last)
  end

  test "should show book_search" do
    get book_search_url(@book_search)
    assert_response :success
  end

  test "should get edit" do
    get edit_book_search_url(@book_search)
    assert_response :success
  end

  test "should update book_search" do
    patch book_search_url(@book_search), params: { book_search: {  } }
    assert_redirected_to book_search_url(@book_search)
  end

  test "should destroy book_search" do
    assert_difference('BookSearch.count', -1) do
      delete book_search_url(@book_search)
    end

    assert_redirected_to book_searches_url
  end
end
