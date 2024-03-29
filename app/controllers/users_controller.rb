class UsersController < ApplicationController
  before_action :require_signed_in!, only: [:edit]
  before_action :require_signed_out!, only: [:create, :new]
  
  def new
    @user = User.new
  end

  def show
    @user = current_user
    @post = @user.posts.build
  end

  def edit
    @user = User.find(params[:id])
    render :edit
  end

  def update
    user = User.find(params[:id])
    
    if user.update_attributes(user_params)
      redirect_to posts_url
    else
      flash.now[:errors] = user.errors.full_messages
    end
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      login!(@user)
      redirect_to :back
    else  
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:username, :password, :email, :first_name, :last_name, :avatar)
  end
end
