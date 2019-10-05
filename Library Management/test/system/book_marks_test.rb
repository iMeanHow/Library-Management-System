require "application_system_test_case"

class BookMarksTest < ApplicationSystemTestCase
  setup do
    @book_mark = book_marks(:one)
  end

  test "visiting the index" do
    visit book_marks_url
    assert_selector "h1", text: "Book Marks"
  end

  test "creating a Book mark" do
    visit book_marks_url
    click_on "New Book Mark"

    fill_in "Book isbn", with: @book_mark.book_isbn
    fill_in "Book title", with: @book_mark.book_title
    fill_in "Student email", with: @book_mark.student_email
    fill_in "Student name", with: @book_mark.student_name
    click_on "Create Book mark"

    assert_text "Book mark was successfully created"
    click_on "Back"
  end

  test "updating a Book mark" do
    visit book_marks_url
    click_on "Edit", match: :first

    fill_in "Book isbn", with: @book_mark.book_isbn
    fill_in "Book title", with: @book_mark.book_title
    fill_in "Student email", with: @book_mark.student_email
    fill_in "Student name", with: @book_mark.student_name
    click_on "Update Book mark"

    assert_text "Book mark was successfully updated"
    click_on "Back"
  end

  test "destroying a Book mark" do
    visit book_marks_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Book mark was successfully destroyed"
  end
end
