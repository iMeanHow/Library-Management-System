class StudentsController < ActionController::Base
# GET /students
# GET /students.json
#
  def student_params
    params.require(:student).permit()
  end

  def index
    @student=Student.all
    @book=Book.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @student }
    end
  end

  def logout

  end

  def show_books
    @book=Book.all
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @book }
    end
  end

  def show_libraries
    @library=Library.all
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @library }
    end
  end

  def show_bookmarked_book

  end

  def checkout_book

  end

  def request_book

  end

  def return_book

  end

  def delete_reservation

  end

  def bookmark_book

  end

  def view_fines

  end

  def update
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

end