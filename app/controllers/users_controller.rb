class UsersController < ApplicationController
  before_filter :authorize, :except => [:new, :create]
  
   def show
     if session[:user_id].to_s != params[:id].to_s
        flash[:notice] = "You are not authorized to see other users pages."
        redirect_to current_user
     else  
        @user = current_user
     end
   end

   def new
     @user = User.new
   end

   def create
     @user = User.create params[:user]
     if !@user
       render :action => :new
     else
       session[:user_id] = @user.id
       flash[:notice] = "Welcome #{@user.name}! Thank you for signing up."
       redirect_to @user
     end
   end

end
