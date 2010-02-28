class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to current_user
    end
  end
  
  def create
    user = User.authenticate(params[:email], params[:password])
     if user
       session[:user_id] = user.id
       redirect_to user
     else
       flash[:notice] = "Invalid email/password combination"
       redirect_to new_sessions_path
     end
  end
  
  def destroy
     session[:user_id] = nil
     flash[:notice] = "Successful logout"
     redirect_to new_sessions_path
   end
end
