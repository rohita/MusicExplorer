class UsersController < ApplicationController
  def show
     @user = User.find(params[:id])
   end

   def new
     @user = User.new
   end

   def create
     @user = User.create params[:user]
     if !@user.valid?
       render :action => :new
     else
        flash[:notice] = "You have sucessfully signed up."
        redirect_to @user
     end
   end
   
   def index
     @users = User.all
   end

end
