class BooksController < ApplicationController
  before_action :verify
  before_action :set_book, only: [:show, :edit, :update, :destroy,:borrow,:book_request]

  def borrow
    @book=Book.find(params[:id])
    @book.nums_borrowed =@book.nums_borrowed+1
    @book_history=BookHistory.new
    @book_history.borrow_time=Time.now
    @book_history.book_isbn=@book.isbn
    @book_history.book_title=@book.title
    @book_history.student_name=current_user.name
    @book_history.student_email=current_user.email
    @book_history.is_returned=false

    respond_to do |format|
      if @book.save && @book_history.save
        # redirect_to @book, notice: 'Book was successfully borrowed.'
        # render :show, status: :ok, location: @book,alert: 'Book was successfully borrowed.'
        format.html { redirect_to @book, notice: 'Book was successfully borrowed.' }
        format.json { render :show, status: :ok, location: @book }
      else
        # render :show
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
        # render json: @book.errors, status: :unprocessable_entity
      end
    end

  end

  def book_request
    @book=Book.find(params[:id])
    @book_request=BookRequest.new
    @book_request.book_title=@book.title
    puts "==========================="
    puts @book_request.book_title
    @book_request.book_isbn=@book.isbn
    @book_request.student_name=current_user.name
    @book_request.student_email=current_user.email
    @book_request.is_delete = false
    @book_request.is_accomplished = false

    respond_to do |format|
      if @book_request.save
        format.html { redirect_to book_requests_path, notice: 'Book was successfully requested.' }
        format.json { render :show, status: :ok, location: @book }

      else
        # # render :show
        format.html { redirect_to book_requests_path, notice: 'Requeste Failed.' }
        format.json { render json: @book_request.errors, status: :unprocessable_entity }

      end
    end
  end


  # GET /books
  # GET /books.json
  def index
    # @books = Book.paginate_by_sql("select * from books where is_delete='false'")
    @books=Book.find_by_sql("select * from books where is_delete=false ")
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
  end

  # GET /books/1/edit
  def edit
    @books = Book.find(params[:id])
  end

  # POST /books
  # POST /books.json
  def create
    @user=current_user
    if verify_admin || verify_librarian
    @book=Book.new(book_params)

    if(@user.role=='librarian')
      @book.library=@user.library
    end
    @book.is_delete=false
    @book.nums_borrowed=0

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
    if verify_admin || (verify_librarian && current_user.library == @book.library)
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

    @book=Book.find(params[:id])
    if verify_admin || (verify_librarian && current_user.library == @book.library)
    @book.is_delete=true
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:image,:isbn,:title,:summary,:nums_total, :nums_borrowed, :is_special,:is_delete,:published_time,:subject,:language,:authors,:edition,:library)
    end
end
