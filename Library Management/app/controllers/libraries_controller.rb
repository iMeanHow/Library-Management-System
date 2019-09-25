class LibrariesController< ActionController::Base
  # GET /libraries
  # GET /libraries.json
  #
  def library_params
    params.require(:library).permit()
  end

  def index
    @library=Library.all
    @library=Library.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @library }
    end
  end

  def show
    @library=Library.find(params[:Name])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @library }
    end
  end

  def new
    @library=Library.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @library }
    end
  end

  def edit
    @library = Library.find(params[:Name])
  end

  def create
    @library = Library.new(library_params)

    respond_to do |format|
      if @library.save
        format.html { redirect_to @library, notice: 'library was successfully created.' }
        format.json { render json: @library, status: :created, location: @library }
      else
        format.html { render action: "new" }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /librarys/1
  # PUT /librarys/1.json
  def update
    @library = Library.find(params[:Name])

    respond_to do |format|
      if @library.update_attributes(library_params)
        format.html { redirect_to @library, notice: 'library was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /librarys/1
  # DELETE /librarys/1.json
  def destroy
    @library = Library.find(params[:id])
    @library.destroy

    respond_to do |format|
      format.html { redirect_to librarys_url }
      format.json { head :no_content }
    end
  end


end