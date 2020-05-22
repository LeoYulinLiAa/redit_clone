class SessionsController < ApplicationController

  before_action :require_not_logged_in, only: %i[create new]
  before_action :require_logged_in, except: %i[create new]

  def create
    user = User.find_by_credential(params[:user][:username], params[:user][:password])
    if user
      login(user)
      redirect_to user_path(user)
    else
      flash[:errors] = ['Invalid Username or Password']
      redirect_to new_session_path
    end
  end

  def new
    render :new
  end

  def destroy
    logout
    redirect_to new_session_path
  end

end
