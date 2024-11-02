class CommentsController < ApplicationController
    before_action :authenticate_user!
    def create
        @post = Post.find(params[:post_id])
        @unsaved_comment = @post.comments.new(comment_params)
        puts @post.comments.count
        @unsaved_comment.commenter = @current_user.username
        @unsaved_comment.post_id = @post.id
        @unsaved_comment.user_id = @current_user.id
        puts @unsaved_comment.commenter
        if @unsaved_comment.save
            redirect_to post_path(@post)
        else 
            render 'posts/show',  status: :unprocessable_entity
        end
    end

    private
    def comment_params
        params.require(:comment).permit(:body)
    end
    def authenticate_user!
        @current_user = User.find_by(id:session[:user_id]) if session[:user_id]
        redirect_to login_path unless @current_user
    end
end
