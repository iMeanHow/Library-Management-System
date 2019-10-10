class BookHistoriesController < ApplicationController
  before_action :set_book_history, only: [:show, :edit, :update, :destroy,:book_return]
  before_action :verify
  # GET /book_histories
  # GET /book_histories.json
  def index
    @book_histories = BookHistory.all
  end

  # GET /book_histories/1
  # GET /book_histories/1.json
  def show
  end

  def return

  end
  # GET /book_histories/new
  def new
    @book_history = BookHistory.new
  end

  # GET /book_histories/1/edit
  def edit
  end

  def book_return
      @user=current_user
      @user.borrow_num=@user.borrow_num - 1
      @user.save
      @book=Book.find_by(isbn: @book_history.book_isbn)
      puts @book.nums_borrowed
      @book.nums_borrowed=@book.nums_borrowed - 1
      @book_history.is_returned=true
      @book_request=BookRequest.find_by_book_isbn_and_is_hold_request_and_is_delete(@book.isbn,true,false)
      if(@book_request!=nil)
        @book_request.is_delete=true
        @book_request.is_accomplished=true
        @borrower=User.find_by_email(@book_request.student_email)
        max = 1<<64
        max = 2 if (@borrower.education_level == 'undergraduate')
        max = 4 if (@borrower.education_level == 'master')
        max = 6 if (@borrower.education_level == 'phd')
        if(@borrower.borrow_num.nil?)
          @borrower.borrow_num=0
          @borrower.save
        end
        if(@borrower.borrow_num<max)
        LibMailer.send_email(@borrower,@book).deliver_now
        @book.nums_borrowed=@book.nums_borrowed + 1
        @book.nums_request=@book.nums_request-1
        @book_history1 = BookHistory.new
        @book_history1.borrow_time = Time.now
        @book_history1.book_isbn = @book.isbn
        @book_history1.book_title = @book.title
        @book_history1.student_name = @borrower.name
        @book_history1.student_email = @borrower.email
        @book_history1.is_returned = false
        @book_history1.library = @book.library
        @borrower.borrow_num=@borrower.borrow_num+1
        @borrower.save
        @book_history1.save
        else
          LibMailer.send_failure_email(@borrower,@book).deliver_now

        end
        @book.nums_request=@book.nums_request-1
        if(@book.nums_request<0)
          @book.nums_request=0
        end
        @book.save
        @book_request.save
      end

      # update request list here
      respond_to do |format|
        if @book_history.save && @book.save && @user.save
          format.html { redirect_to @book_history, notice: 'Book was successfully returned.' }
          format.json { render :show, location: @book_history }
        else
          format.html { redirect_to @book_history, notice: 'Book return failed.' }
          format.json { render :show, location: @book_history }
        end
      end
  end

  # POST /book_histories
  # POST /book_histories.json
  def create
    @book_history = BookHistory.new(book_history_params)

    respond_to do |format|
      if @book_history.save
        format.html { redirect_to @book_history, notice: 'Book history was successfully created.' }
        format.json { render :show, status: :created, location: @book_history }
      else
        format.html { render :new }
        format.json { render json: @book_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /book_histories/1
  # PATCH/PUT /book_histories/1.json
  def update
    respond_to do |format|
      if @book_history.update(book_history_params)
        format.html { redirect_to @book_history, notice: 'Book history was successfully updated.' }
        format.json { render :show, status: :ok, location: @book_history }
      else
        format.html { render :edit }
        format.json { render json: @book_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /book_histories/1
  # DELETE /book_histories/1.json
  def destroy
    @book_history.destroy
    respond_to do |format|
      format.html { redirect_to book_histories_url, notice: 'Book history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book_history
      @book_history = BookHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_history_params
      params.require(:book_history).permit(:borrow_time,:return_time,:overdue_fine,:book_title,:book_isbn,:student_name,:student_email,:library)
    end
end
