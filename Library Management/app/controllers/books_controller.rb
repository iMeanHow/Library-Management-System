class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def borrow
    @book=Book.find(params[:id])

    if @book.is_borrowed==false
      @book.is_borrowed=true
      if @book.save
        render :show, status: ok, location: @book
      else
        render :show, status: :unprocessable_entity
      end
      # create_history(@book,@session[:id])
    else

    end
  end

  def create_history(book,student)
    @book=book
    @student=student
    @book_history=BookHistory.new
    @book_history.time=Time.current
    @book_history.book_ISBN=@book.isbn
    @book_history.book_title=@book.title
    @book_history.student_name=@student.name
    @book_history.student_email=@student.email
    @book_history.is_returned=false
  end

  def return
    @book=Book.find(params[:isbn])
    # @student=Student.find(@session[:id])
    @book_history=BookHistory.find(params[:id])
    @book_history.is_returned=true
    @book.is_borrowed=false
    if @book.save && @book_history.save
      render :show, status: ok, location: @book
    else
      render :show, status: :unprocessable_entity
    end
  end

  def request_book
    @book_request=BookRequest.new
  end

  def cancel_request
    @book_request=BookRequest.find(params[:id])
    @book_request.is_delete=true
    if @book_request.save
      render :show, status: ok, location: @book
    else
      render :show, status: :unprocessable_entity
    end
  end
  # GET /books
  # GET /books.json
  def index
    # @books = Book.paginate_by_sql("select * from books where is_delete='false'")
    @books=Book.all
  end

  # GET /books/1
  # GET /books/1.json
  def show
    # @books = Book.all
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
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book=Book.find(params[:id])
    @book.is_delete=true
    @book.save
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:isbn,:title,:summary,:borrowed,:is_special,:is_delete,:published_time,:subject,:language,:authors,:edition,:image,)
    end
end
