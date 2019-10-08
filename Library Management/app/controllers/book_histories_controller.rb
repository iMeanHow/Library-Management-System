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
      @book=Book.find_by(isbn: @book_history.book_isbn)
      puts "==========================="
      puts @book.nums_borrowed
      @book.nums_borrowed=@book.nums_borrowed - 1
      @book_history.is_returned=true
      # update request list here

      respond_to do |format|
        if @book_history.save && @book.save && @user.save
          puts "==========================="
          format.html { redirect_to @book_history, notice: 'Book was successfully returned.' }
          format.json { render :show, location: @book_history }
        else
          puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
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
