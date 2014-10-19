class PostsController < ApplicationController
  def new
    @post = Post.new
    @user = current_user
  end
  
  def index
    @posts = Post.all
    @users = User.all
    render :index
  end
  
  def create
    post = current_user.posts.new(post_params)
    
    if post.save
      redirect_to post_url(post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end
  
  def show
    @post = Post.find(params[:id])
    render :show
  end
  
  private
  def post_params
    params.require(:post).permit(:title, :body)
  end
end
