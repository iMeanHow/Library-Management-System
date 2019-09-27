class BookSearchesController < ApplicationController
  before_action :set_book_search, only: [:show, :edit, :update, :destroy]

  # GET /book_searches
  # GET /book_searches.json
  def index
    @book_searches = BookSearch.all
  end

  # GET /book_searches/1
  # GET /book_searches/1.json
  def show
  end

  # GET /book_searches/new
  def new
    @book_search = BookSearch.new
  end

  # GET /book_searches/1/edit
  def edit
  end

  # POST /book_searches
  # POST /book_searches.json
  def create
    @book_search = BookSearch.new(book_search_params)

    respond_to do |format|
      if @book_search.save
        format.html { redirect_to @book_search, notice: 'Book search was successfully created.' }
        format.json { render :show, status: :created, location: @book_search }
      else
        format.html { render :new }
        format.json { render json: @book_search.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /book_searches/1
  # PATCH/PUT /book_searches/1.json
  def update
    respond_to do |format|
      if @book_search.update(book_search_params)
        format.html { redirect_to @book_search, notice: 'Book search was successfully updated.' }
        format.json { render :show, status: :ok, location: @book_search }
      else
        format.html { render :edit }
        format.json { render json: @book_search.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /book_searches/1
  # DELETE /book_searches/1.json
  def destroy
    @book_search.destroy
    respond_to do |format|
      format.html { redirect_to book_searches_url, notice: 'Book search was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book_search
      @book_search = BookSearch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_search_params
      params.fetch(:book_search, {})
    end
end
