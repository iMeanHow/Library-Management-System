class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    begin
      @current_user ||= User.find(session[:user_id])
    rescue
      @current_user = nil
    end
  end

  def verify
    @current_user=current_user
    if @current_user.nil?
        redirect_to login_path
    end

  end

  def verify_admin
    @current_user=current_user
    @current_user.role=='admin'
  end

  def verify_librarian
    @current_user=current_user
    @current_user.role=='librarian'
  end

  def already_login?
    @current_user = current_user
    @current_user.nil?
  end
end
