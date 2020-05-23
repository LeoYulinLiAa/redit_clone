class PostsController < ApplicationController

  helper_method :current_post, :current_author, :full_permission?, :subs

  before_action :require_logged_in, except: %i[show]
  before_action :require_permission, except: %i[show new create]

  def show
    if current_post
      render :show
    else
      raise ActionController::RoutingError, 'Not Found'
    end
  end

  def new
    @current_post = Post.new
    render :new
  end

  def create
    @current_post = Post.new(post_params)
    current_post.author = current_user
    if current_post.save
      redirect_to post_path(current_post)
    else
      flash.now[:errors] = current_post.errors.full_messages
      render :new
    end
  end

  def edit
    render :edit
  end

  def update
    if Post.find_by_id(params[:id]).update(post_params)
      redirect_to post_path(current_post)
    else
      flash.now[:errors] = current_post.errors.full_messages
      render :update
    end
  end

  def destroy
    current_post.destroy
    redirect_to subs_path
  end

  def current_post
    @current_post ||= Post.find_by_id(params[:id])
  end

  def subs
    @subs ||= Sub.all
  end

  def current_author
    @current_author ||= current_post.author
  end

  def author?
    current_user == current_author
  end

  def require_permission
    unless full_permission?
      flash[:errors] = ['Unauthorized access']
      redirect_to post_path(current_post)
    end
  end

  def full_permission?
    author? || current_sub.moderator == current_user
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_ids)
  end

end
