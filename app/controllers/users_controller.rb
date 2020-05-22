class UsersController < ApplicationController

  before_action :require_not_logged_in, only: %i[create new]

  def show
    @user = User.find_by_id(params[:id])
  end

  def create
    user = User.new(params.require(:user).permit(:username, :email, :password))
    if user.save
      login(user)
      redirect_to user_path(user)
    else
      flash[:errors] = user.errors.full_messages
    end
  end

  def new
    render :new
  end
end
