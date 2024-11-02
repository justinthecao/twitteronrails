class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    puts @user.username
    if @user.save
      session[:user_id] = @user.id
    else 
      session[:user_id] = User.find_by(username: @user.username).id
    end
    puts "Userid #{session[:user_id]}"
    redirect_to root_path
  end

  def delete
    session.delete(:user_id)
    redirect_to login_path
  end

  private
    def user_params
      params.require(:user).permit(:username)
    end
end
