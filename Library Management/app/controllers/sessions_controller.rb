class SessionsController < ApplicationController
  def new
  end

  def create
    begin
      user = User.find_by_email(params[:email])
      if user && user.authenticate(params[:password])
        if current_user.nil?
          session[:user_id] = user.id
          redirect_to root_url, notice: "Created!"
        end

        redirect_to root_url, notice: "Logged in!"
      else
        flash.now[:alert] = "Email or password is invalid"
        render "new"
      end
    rescue Exception => e
      logger.error(e.message)
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end


end
