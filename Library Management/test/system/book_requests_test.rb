require "application_system_test_case"

class BookRequestsTest < ApplicationSystemTestCase
  setup do
    @book_request = book_requests(:one)
  end

  test "visiting the index" do
    visit book_requests_url
    assert_selector "h1", text: "Book Requests"
  end

  test "creating a Book request" do
    visit book_requests_url
    click_on "New Book Request"

    click_on "Create Book request"

    assert_text "Book request was successfully created"
    click_on "Back"
  end

  test "updating a Book request" do
    visit book_requests_url
    click_on "Edit", match: :first

    click_on "Update Book request"

    assert_text "Book request was successfully updated"
    click_on "Back"
  end

  test "destroying a Book request" do
    visit book_requests_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Book request was successfully destroyed"
  end
end
