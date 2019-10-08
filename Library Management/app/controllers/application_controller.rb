class ApplicationController < ActionController::Base
  helper_method :current_user,:verify,:verify_admin,:verify_librarian,:overdue_calculator

  def current_user
    begin
      @current_user ||= User.find(session[:user_id])
    rescue
      @current_user = nil
    end
  end

  def verify
    @current_user=current_user
    if @current_user.nil?
        redirect_to login_path
    end

  end

  def verify_admin
    @current_user=current_user
    @current_user.role=='admin'
  end

  def verify_librarian
    @current_user=current_user
    @current_user.role=='librarian'
  end

  def already_login?
    @current_user = current_user
    @current_user.nil?
  end

  def overdue_calculator
    @book_histories=BookHistory.find_by_sql('select * from book_histories where is_returned=false')
    if !@book_histories.nil?
    @book_histories.each do |book_history|
      @book=Book.find_by_isbn(book_history.book_isbn)
      @library=Library.find_by_name(@book.library)
      lasts=(Time.current.to_date-book_history.created_at.to_date).to_i
      if lasts>@library.max_borrow
        @user=User.find_by_email(book_history.student_email)
        @user.fine=lasts*@library.overdue_fine
        @user.save
      end
    end
    end
  end

end
