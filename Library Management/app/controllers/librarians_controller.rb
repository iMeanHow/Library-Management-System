class LibrariansController<ApplicationController::Base
# GET /librarians
# GET /librarians.json
#
  def librarian_params
    params.require(:librarian).permit()
  end

  def index
    @book=Book.all
    @library=Library.all
    @librarian=Librarian.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @librarian }
    end
  end

  def logout

  end


  def show
    @librarian=Librarian.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @librarian }
    end
  end

  def show_hold_request
    @book=Book.find(params[])
  end

  def new
    @librarian=Librarian.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @librarian }
    end
  end

  def edit
    @librarian = Librarian.find(params[:id])
  end

  def edit_library
    @librarian = Librarian.find(params[:id])
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

  def delete_book
    @book = Book.find(params[:id])
    @book.destroy

    respond_to do |format|
      format.html { redirect_to librarians_url }
      format.json { head :no_content }
    end
  end

  # PUT /librarians/1
  # PUT /librarians/1.json
  def update
    @librarian = Librarian.find(params[:Name])

    respond_to do |format|
      if @librarian.update_attributes(librarian_params)
        format.html { redirect_to @librarian, notice: 'librarian was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @librarian.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_library
    @library = Library.find(params[:Name])

    respond_to do |format|
      if @library.update_attributes(librarian_params)
        format.html { redirect_to @library, notice: 'library was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit_library" }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end


end