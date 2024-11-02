class PostsController < ApplicationController
  rescue_from ActionController::RoutingError, with: :render_not_found  

  before_action :authenticate_user!

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @unsaved_comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = @current_user.id
    if @post.save
      redirect_to post_path(@post)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:id])
    if @post.user_id != @current_user.id
      redirect_to post_path(@post)
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end
  def destroy
    @post = Post.find(params[:id])
    if @post.user_id != @current_user.id
      redirect_to post_path(@post)
    else
      @post.destroy
      redirect_to root_path, status: :see_other
    end
  end
  private
    def post_params
      params.require(:post).permit(:title, :body)
    end
    def authenticate_user!
        puts "Session #{session[:user_id]}"
        @current_user = User.find_by(id:session[:user_id]) if session[:user_id]
        redirect_to login_path unless @current_user
    end
    def render_not_found
      render file: "#{Rails.root}/public/404.html", status: :not_found
    end
end



