class AdminController< ActionController::Base
  def admin_params
    params.require(:name).permit()
  end

  def index
    @admin=Admin.all
    @library=Library.all
    @librarian=Librarian.all
    @student=Student.all
    @book=Book.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin }
    end
  end

  def logout

  end

  def show

  end

  def show_libraries
    @library=Library.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @library }
    end
  end

  def show_users
    @user=User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def show_librarians
    @librarian=Librarian.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @librarian }
    end
  end

  def show_studnets
    @student=Student.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @student }
    end
  end

  def show_students_overdue
    @student=Student.find(params[:Overdue])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @student }
    end
  end

  def show_books
    @book=Book.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @book }
    end
  end

  def show_books_hold_request

  end

  def show_books_checked_out

  end

  def show_books_overdue

  end

  def show_books_borrow_history

  end

  def create_student
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: 'student was successfully created.' }
        format.json { render json: @student, status: :created, location: @student }
      else
        format.html { render action: "new" }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_librarian
    @librarian = Librarian.new(librarian_params)

    respond_to do |format|
      if @librarian.save
        format.html { redirect_to @librarian, notice: 'librarian was successfully created.' }
        format.json { render json: @librarian, status: :created, location: @librarian }
      else
        format.html { render action: "new" }
        format.json { render json: @librarian.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_book
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'book was successfully created.' }
        format.json { render json: @book, status: :created, location: @book }
      else
        format.html { render action: "new" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_library
    @library = Library.new(library_params)

    respond_to do |format|
      if @library.save
        format.html { redirect_to @library, notice: 'library was successfully created.' }
        format.json { render json: @library, status: :created, location: @library }
      else
        format.html { render action: "new" }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit_book
    @book=Book.find(params[:id])
  end

  def edit_student
    @student=Student.find(params[:id])
  end

  def edit_librarian
    @librarian=Librarian.find(params[:id])
  end

  def edit_library
    @library=Library.find(params[:id])
  end

  def update_student
    @student = Student.find(params[:id])

    respond_to do |format|
      if @student.update_attributes(student_params)
        format.html { redirect_to @student, notice: 'student was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit_student" }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_librarian
    @librarian = Librarian.find(params[:id])

    respond_to do |format|
      if @librarian.update_attributes(librarian_params)
        format.html { redirect_to @librarian, notice: 'librarian was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit_librarian" }
        format.json { render json: @librarian.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_book
    @book = Book.find(params[:id])

    respond_to do |format|
      if @book.update_attributes(book_params)
        format.html { redirect_to @book, notice: 'book was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit_book" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_library
    @library = Library.find(params[:id])

    respond_to do |format|
      if @library.update_attributes(library_params)
        format.html { redirect_to @library, notice: 'library was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit_library" }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete_student
    @student = Student.find(params[:id])
    @student.destroy

    respond_to do |format|
      format.html { redirect_to admin_url }
      format.json { head :no_content }
    end
  end

  def delete_librarian
    @librarian = Librarian.find(params[:id])
    @librarian.destroy

    respond_to do |format|
      format.html { redirect_to admin_url }
      format.json { head :no_content }
    end
  end

  def delete_book
    @book = Book.find(params[:id])
    @book.destroy

    respond_to do |format|
      format.html { redirect_to admin_url }
      format.json { head :no_content }
    end
  end

  def delete_library
    @library = Library.find(params[:id])
    @library.destroy

    respond_to do |format|
      format.html { redirect_to admin_url }
      format.json { head :no_content }
    end
  end

end