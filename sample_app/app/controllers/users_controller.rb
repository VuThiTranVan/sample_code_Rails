class UsersController < ApplicationController
  before_action :logged_in_user, except: [:show, :new, :create]
  # tuong duong before_action :logged_in_user, only: [:edit, :update, :destroy, :index]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :load_user, except: [:index, :new, :create]
  # tuong duong voi before_action :load_user, only: [:show, :update, :edit, :destroy]

  def index
    @users = User.paginate page: params[:page],
      per_page: Settings.user.max_record_display
  end

  def show
    # load_user # vi da co goi before action
    return if @user
    flash[:danger] = t "users.show.no_user_msg"
    redirect_to signup_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      # Login upon signup
      log_in @user
      flash[:success] = t "users.new.create_success"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
    # load_user
  end

  def update
    # load_user
    return render(:edit) unless @user.update_attributes user_params
    flash[:success] = t "users.edit.edit_success"
    redirect_to @user
  end

  def destroy
    if @user.destroy
      flash[:success] = t "users.destroy.destroy_success"
    else
      flash[:danger] = t "users.destroy.destroy_error"
    end
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "users.edit.required_login_msg"
      redirect_to login_path
    end
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
    @user || render(file: "public/404.html", status: 404, layout: true)
  end
end
