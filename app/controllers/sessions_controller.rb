class SessionsController < ApplicationController
  def new
  end
  
  def create
    email = params[:user][:email]
    password = params[:user][:password]
    @user = User.find_by_credentials(email, password)
    
    if @user
      login!(@user)
      redirect_to user_url(@user)
    else
      @user = User.new(email: email, password: password)
      
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
    params.require(:user).permit(:email, :password)
  end
end
