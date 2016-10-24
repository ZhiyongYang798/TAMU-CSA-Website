class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by(name: params[:session][:name])
    if @user != nil && @user[:uin] == params[:session][:uin]&& @user.authenticate(params[:session][:password]) # add the password for checking to login, which is lacked in the legacy code. 
      # Log the user in and redirect to the user's show page.
      log_in (@user)
      redirect_to @user
    else
      # Create an error message.
      flash.now[:danger] = 'Invalid Name or UIN !' # Not quite right!
      render 'new'
    end
  end
  
  def destroy
    log_out
    redirect_to root_url
  end
    # Logs in the given user.
    
    
  def log_in(user)
    session[:user_id] = user.id
  end
  
  # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Logs out the current user.
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  

  
  
end
