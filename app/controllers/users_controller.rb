class UsersController < ApplicationController
  before_filter :authorize, :except => [:new, :create]
  
   def show
     if session[:user_id].to_s != params[:id].to_s
        flash[:notice] = "You are not authorized to see other users pages."
        redirect_to current_user
     else  
        @user = current_user
        @library = @user.library
        
        respond_to do |wants|
          wants.html do render end
          wants.js do render :partial => "favs" end
        end
        
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
   
   def update
     @user = current_user
     file_path = "#{RAILS_ROOT}/public/data/#{@user.id}.xml"
     if params[:file].instance_of?(Tempfile)
       FileUtils.copy(params[:file].local_path, file_path)
     else
       File.open(file_path,"w"){|f|
                f.write(params[:file].read)
                f.close}
     end 
     
     library = Library.new
     library.parse(file_path)
     File.delete(file_path)
     
     @user.library.destroy unless @user.library.nil?
     @user.library = library
     @user.save!
     
     redirect_to @user
   end

end
