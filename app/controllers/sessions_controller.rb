class SessionsController < ApplicationController
  def new
  end
  
  def create
    username = params[:user][:username]
    password = params[:user][:password]
    @user = User.find_by_credentials(username, password)
    
    if @user
      login!(@user)
      redirect_to :back
    else
      @user = User.new(username: username, password: password)
      
      if @user.save
        login!(@user)
        redirect_to :back
      else
        flash.now[:errors] = @user.errors.full_messages
        render 'users/new'
      end
    end
  end
  
  def destroy 
    logout!
    redirect_to root_path
  end
  
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
