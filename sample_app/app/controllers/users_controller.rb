class UsersController < ApplicationController
  before_action :logged_in_user, except: [:show, :new, :create]
  # tuong duong before_action :logged_in_user, only: [:edit, :update, :destroy, :index]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :load_user, except: [:index, :new, :create]
  # tuong duong voi before_action :load_user, only: [:show, :update, :edit, :destroy]

  def index
    @users = User.where(activated: true).paginate page: params[:page],
      per_page: Settings.user.max_record_display
  end

  def show
    @microposts = @user.microposts.paginate page: params[:page],
      per_page: Settings.micropost.max_record_display

    redirect_to root_path unless @user.activated?
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "activation.please_check_email"
      redirect_to root_path
    else
      flash.now[:danger] = t "users.new.create_fail"
      render :new
    end
  end

  def edit
    # load_user
  end

  def update
    # load_user
    if @user.update_attributes user_params
      flash[:success] = t "users.edit.edit_success"
      redirect_to @user
    else
      flash.now[:danger] = t "users.edit.update_error"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "users.destroy.destroy_success"
    else
      flash[:danger] = t "users.destroy.destroy_error"
    end
    redirect_to users_url
  end

  def following
    @title = t "users.flow_user.following"
    load_user
    @users = @user.following.paginate page: params[:page],
      per_page: Settings.user.smax_record_display
    render :show_follow
  end

  def followers
    @title = t "users.flow_user.followers"
    load_user
    @users = @user.followers.paginate page: params[:page],
      per_page: Settings.user.smax_record_display
    render :show_follow
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  # Confirms the correct user.
  def correct_user
    # @user = User.find_by id: params[:id]
    load_user
    redirect_to root_url unless current_user? @user
  end

  # Confirms an admin user.
  def admin_user
    redirect_to root_path unless current_user.admin?
  end

  # Loading user by id
  def load_user
    @user = User.find_by id: params[:id]
    valid_info @user
  end
end
