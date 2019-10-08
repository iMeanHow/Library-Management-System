class BooksController < ApplicationController
  before_action :verify
  before_action :set_book, only: [:show, :edit, :update, :destroy, :borrow, :book_request, :mark_book, :unmark_book]

  def mark_book
    @book = Book.find(params[:id])
    @book_mark = BookMark.new
    @book_mark.book_title = @book.title
    @book_mark.book_isbn = @book.isbn
    @book_mark.student_email = current_user.email
    @book_mark.student_name = current_user.name
    respond_to do |format|
      if @book_mark.save
        # redirect_to @book, notice: 'Book was successfully borrowed.'
        # render :show, status: :ok, location: @book,alert: 'Book was successfully borrowed.'
        format.html { redirect_to @book, notice: 'Book was successfully marked.' }
        format.json { render :show, status: :ok, location: @book }
      else
        # render :show
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
        # render json: @book.errors, status: :unprocessable_entity
      end
    end
  end

  def unmark_book
    @book = Book.find(params[:id])
    # puts "============================================"
    puts BookMark.find_by_book_isbn_and_student_email(@book.isbn, current_user.email)
    @book_mark = BookMark.find_by_book_isbn_and_student_email(@book.isbn, current_user.email)

    respond_to do |format|
      if @book_mark.destroy
        # redirect_to @book, notice: 'Book was successfully borrowed.'
        # render :show, status: :ok, location: @book,alert: 'Book was successfully borrowed.'
        format.html { redirect_to @book, notice: 'Book was successfully unmarked.' }
        format.json { render :show, status: :ok, location: @book }
      else
        # render :show
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
        # render json: @book.errors, status: :unprocessable_entity
      end
    end
  end

  def borrow_without_check_2
    user = User.find_by_email(params[:email])
    book = Book.find_by_isbn(params[:isbn])
    borrow_without_check(user, book)
  end

  def borrow_without_check(user, book)
    if (user.education_level == 'undergraduate')
      max = 2
    end
    if (user.education_level == 'master')
      max = 4
    end
    if (user.education_level == 'phd')
      max = 6
    end
    if (user.borrow_num < max || user.role == 'admin')
      book.nums_borrowed = book.nums_borrowed + 1
      user.borrow_num += 1
      user.save
      @book_history = BookHistory.new
      @book_history.borrow_time = Time.now
      @book_history.book_isbn = book.isbn
      @book_history.book_title = book.title
      @book_history.student_name = user.name
      @book_history.student_email = user.email
      @book_history.is_returned = false
      @book_history.library = book.library
      respond_to do |format|
        if book.save && @book_history.save
          # redirect_to @book, notice: 'Book was successfully borrowed.'
          # render :show, status: :ok, location: @book,alert: 'Book was successfully borrowed.'
          format.html { redirect_to book, notice: 'Book was successfully borrowed.' }
          format.json { render :show, status: :ok, location: book }
        else
          # render :show
          format.html { render :edit }
          format.json { render json: book.errors, status: :unprocessable_entity }
          # render json: @book.errors, status: :unprocessable_entity
        end
      end

    else
      redirect_to book, notice: 'Failed! Max borrow number reached already.'
    end
  end

  def borrow
    @book = Book.find(params[:id])
    @library=Library.find_by_name(@book.library)
    if((current_user.role=='librarian' && current_user.library==@library.name )||current_user.university==@library.university)
      if (@book.is_special == true)
        book_request
        return
      else
        borrow_without_check(current_user, @book)
      end
    else
      redirect_to books_url, notice: 'Failed! Unauthorized action.'
    end
  end

  def book_request
    @book = Book.find(params[:id])
    @library=Library.find_by_name(@book.library)
    if((current_user.role=='librarian' && current_user.library==@library.name )||current_user.university==@library.university)
      @book = Book.find(params[:id])
      @book_request = BookRequest.new
      @book_request.book_title = @book.title
      @book_request.book_isbn = @book.isbn
      @book_request.student_name = current_user.name
      @book_request.student_email = current_user.email
      @book_request.is_delete = false
      @book_request.is_accomplished = false
      @book_request.library = @book.library
      respond_to do |format|
        if @book_request.save &&
          format.html { redirect_to book_requests_path, notice: 'Book was successfully requested.' }
          format.json { render :show, status: :ok, location: @book }

        else
          # # render :show
          format.html { redirect_to book_requests_path, notice: 'Requeste Failed.' }
          format.json { render json: @book_request.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to books_url, notice: 'Failed! Unauthorized action.'
    end
  end


  # GET /books
  # GET /books.json
  def index
    # @books = Book.paginate_by_sql("select * from books where is_delete='false'")
    @books = Book.find_by_sql("select * from books where is_delete=false ")
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @books = Book.find(params[:id])
    puts @book
  end

  # GET /books/new
  def new
    @book = Book.new
    @library = Library.all
  end

  # GET /books/1/edit
  def edit
    @books = Book.find(params[:id])
  end

  # POST /books
  # POST /books.json
  def create
    @user = current_user
    if verify_admin || verify_librarian
      @book = Book.new(book_params)
      @book.nums_request=0
      @book.library = @user.library if (@user.role == 'librarian')
      @book.is_delete = false
      @book.nums_borrowed = 0
      @library=Library.find_by_name(@book.library)
      @book.university=@library.university
      respond_to do |format|
        if @book.save
          format.html { redirect_to @book, notice: 'Book was successfully created.' }
          format.json { render :show, status: :created, location: @book }
        else
          format.html { render :new }
          format.json { render json: @book.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to books_url, notice: 'Unauthorized action!'
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    if verify_admin || (verify_librarian && current_user.role == 'librarian' && current_user.library == @book.library )
      @library=Library.find_by_name(@book.library)
      @book.university=@library.university
      respond_to do |format|
        if @book.update(book_params)
          format.html { redirect_to @book, notice: 'Book was successfully updated.' }
          format.json { render :show, status: :ok, location: @book }
        else
          format.html { render :edit }
          format.json { render json: @book.errors, status: :unprocessable_entity }
        end
      end
    else
      format.html { redirect_to books_url, notice: 'Unauthorized action!' }
      format.json { head :no_content }
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy

    @book = Book.find(params[:id])
    if verify_admin || (verify_librarian && current_user.role == 'librarian' && current_user.library == @book.library)
      @book.is_delete = true
      @book.save
      respond_to do |format|
        format.html { redirect_to books_url, notice: 'Book was successfully deleted.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to books_url, notice: 'Unauthorized action!' }
        format.json { head :no_content }
      end
    end
  end

  def booksearch
    @booksearchresult = Book.find_by_sql("select * from books where #{params[:searchtype]} like '%#{params[:content]}%'")
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_book
    @book = Book.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def book_params
    params.require(:book).permit(:image, :isbn, :title, :summary, :nums_total, :nums_borrowed, :is_special, :is_delete, :published_time, :subject, :language, :author, :edition, :library,:nums_request,:university)
  end
end
