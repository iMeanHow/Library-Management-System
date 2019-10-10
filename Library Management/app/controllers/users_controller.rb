class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :verify, except: [:new, :create]
  # GET /users
  # GET /users.json
  def index
    overdue_calculator
    if (current_user.role == 'admin')
      @userlist = User.all
    elsif (current_user.role == 'librarian')
      @userlist = User.find_by_sql("select * from users where role='student'")
      #@userlist = User.find_by_sql("select * from users")
    elsif (current_user.role == 'student')
      @user = User.find_by(:email => current_user.email)
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    overdue_calculator
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit

  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.fine=0
    if @user.role == "librarian"
      @user.librariansrequest = true
    else
      @user.librariansrequest = false
    end
    if @user.email == "admin@test.com"
      @user.role = "admin"
    end
    @user.borrow_num = 0
    if(current_user!=nil && current_user.role=='admin' && @user.role=='librarian')
      @user.librariansrequest=false
    end
    if(current_user==nil)
    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
    else
      respond_to do |format|
        if @user.save
          format.html { redirect_to @user, notice: 'User was successfully created.' }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @bh = BookHistory.find_by_sql("select * from book_histories where student_email= '%#{@user.email}%'")
    if not @bh.nil?
      @bh.each do |bh|
        if (bh.is_returned == false)
          @book = Book.find_by_isbn(bh.book_isbn)
          @book.nums_total = @book.nums_total -1
          @book.num_borrowed = @book.nums_borrowed -1
          @book.save
        end

        bh.destroy
      end
    end
    @bm = BookMark.find_by_student_email(@user.email)
    if not @bm.nil?
      @bm.each do |bm|
        bm.destroy
      end
    end
    @bq=BookRequest.find_by_student_email(@user.email)
    if not @bq.nil?
      @bq.each do |bq|
        bq.destroy
      end
    end
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def viewrequests
    @librariansNeedtoApprove = User.find_by_sql("select * from users where librariansrequest = 'true'")
  end

  def approvelibrarian()
    print(params[:email])
    @needtoapprove = User.find_by_email(params[:email])
    @needtoapprove.librariansrequest = false
    @needtoapprove.save
    redirect_to librarian_requests_path, notice: 'Approved!'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation, :role, :library, :fine, :borrow_num, :education_level, :university)
  end
end
