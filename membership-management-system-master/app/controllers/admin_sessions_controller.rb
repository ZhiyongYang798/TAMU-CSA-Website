class AdminSessionsController < ApplicationController
  def new
    
  end
  
  def create
    admin = Admin.find_by(uin: params[:session][:uin])
    if admin && admin.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in admin
      #redirect_to admin
      redirect_to static_pages_adminhome_path
    else
      # Create an error message.
      flash.now[:danger] = 'Invalid UIN or Name !' # Not quite right!
      render 'new'
    end
  end
  
  def destroy
    log_out
    redirect_to root_url
  end
  
  def log_in(admin)
    session[:admin_id] = admin.id
  end
  
  # Returns the current logged-in user (if any).
  def current_admin
    @current_admin ||= Admin.find_by(id: session[:admin_id])
  end
  
  # Returns true if the user is logged in, false otherwise.
  def admin_logged_in?
    !current_admin.nil?
  end

  # Logs out the current user.
  def log_out
    session.delete(:admin_id)
    @current_admin = nil
  end
  
end