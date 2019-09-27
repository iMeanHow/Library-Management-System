require "application_system_test_case"

class BookSearchesTest < ApplicationSystemTestCase
  setup do
    @book_search = book_searches(:one)
  end

  test "visiting the index" do
    visit book_searches_url
    assert_selector "h1", text: "Book Searches"
  end

  test "creating a Book search" do
    visit book_searches_url
    click_on "New Book Search"

    click_on "Create Book search"

    assert_text "Book search was successfully created"
    click_on "Back"
  end

  test "updating a Book search" do
    visit book_searches_url
    click_on "Edit", match: :first

    click_on "Update Book search"

    assert_text "Book search was successfully updated"
    click_on "Back"
  end

  test "destroying a Book search" do
    visit book_searches_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Book search was successfully destroyed"
  end
end
