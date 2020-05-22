class SubsController < ApplicationController

  helper_method :current_sub, :moderator?

  before_action :require_logged_in, except: %i[show index]
  before_action :require_moderator, only: %i[edit update]

  def index
    @subs = Sub.all.order(:created_at)
    render :index
  end

  def show
    render :show
  end

  def new
    render :new
  end

  def create
    sub = Sub.new(sub_params)
    sub.moderator = current_user
    if sub.save
      redirect_to sub_path(sub)
    else
      flash[:errors] = sub.errors.full_messages
      redirect_to new_sub_path
    end
  end

  def edit
    render :edit
  end

  def update
    if current_sub.update(sub_params)
      redirect_to sub_path(current_sub)
    else
      flash[:errors] = current_sub.errors.full_messages
      redirect_to edit_sub_path(current_sub)
    end
  end

  def current_sub
    @current_sub ||= Sub.find_by_id(params[:id])
  end

  def moderator
    @moderator ||= current_sub.moderator
  end

  def moderator?
    moderator == current_user
  end

  def require_moderator
    unless moderator?
      flash[:errors] = ["Only moderator can edit a sub"]
      redirect_to sub_path(current_sub)
    end
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end

end
