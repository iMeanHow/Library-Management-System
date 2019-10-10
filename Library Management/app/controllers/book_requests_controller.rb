class BookRequestsController < ApplicationController
  before_action :set_book_request, only: [:show, :edit, :update, :destroy]
  before_action :verify

  def approve
    email = params[:email]
    isbn = params[:isbn]
    book=Book.find_by_isbn(isbn)
    if(book.nums_borrowed>=book.nums_total)
      redirect_to  book_requests_path, notice: 'Can not approve! No book left in the library.'
    end
    id = params[:id]
    bookrequest = BookRequest.find(id)
    bookrequest.is_accomplished = true
    bookrequest.save
    # @book = Book.find_by_isbn(isbn)
    # @book.nums_request = @book.nums_request - 1
    # @book.save
    user=User.find_by_email(email)
    book.nums_request -=1
    if book.nums_request<0
      book.nums_request=0
    end
    book.save
    redirect_to borrow_book_without_check_path(email: email, isbn: isbn)
  end

  def deny
    id = params[:id]
    isbn = params[:isbn]
    bookrequest = BookRequest.find(id)
    @book=Book.find_by_isbn(isbn)
     #minus the request num if canceled by student
      @book.nums_request = @book.nums_request - 1
      if    @book.nums_request<0
        @book.nums_request=0
      end
      @book.save
    bookrequest.is_delete=true
    bookrequest.is_accomplished = true
    bookrequest.save
    @user=User.find_by_email(bookrequest.student_email)
    LibMailer.send_failure_email(@user,@book).deliver_now
    redirect_to book_requests_path(id: isbn)
  end

  def holdrequestindex()
    @book_hold_requests = BookRequest.find_by_sql("select * from book_requests where is_hold_request = true")
  end

  # GET /book_requests
  # GET /book_requests.json
  def index()
    @book_requests = BookRequest.find_by_sql("select * from book_requests where is_hold_request = false")
    # @book_requests = BookRequest.all
  end

  # GET /book_requests/1
  # GET /book_requests/1.json
  def show
  end

  # GET /book_requests/new
  def new
    @book_request = BookRequest.new
  end

  # GET /book_requests/1/edit
  def edit
  end

  # POST /book_requests
  # POST /book_requests.json
  def create
    @book_request = BookRequest.new(book_request_params)

    respond_to do |format|
      if @book_request.save
        format.html { redirect_to @book_request, notice: 'Book request was successfully created.' }
        format.json { render :show, status: :created, location: @book_request }
      else
        format.html { render :new }
        format.json { render json: @book_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /book_requests/1
  # PATCH/PUT /book_requests/1.json
  def update
    respond_to do |format|
      if @book_request.update(book_request_params)
        format.html { redirect_to @book_request, notice: 'Book request was successfully updated.' }
        format.json { render :show, status: :ok, location: @book_request }
      else
        format.html { render :edit }
        format.json { render json: @book_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /book_requests/1
  # DELETE /book_requests/1.json
  def destroy
    @user=User.find_by_email(@book_request.student_email)
    @book=Book.find_by_isbn(@book_request.book_isbn)
    LibMailer.send_failure_email(@user,@book).deliver_now
    @book_request.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_book_request
    @book_request = BookRequest.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def book_request_params
    params.require(:book_request).permit(:is_delete, :is_accomplished, :book_title, :book_isbn, :student_name, :student_email, :library,:ishold)
  end
end
