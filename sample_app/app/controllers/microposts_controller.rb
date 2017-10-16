class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build micropost_params

    if @micropost.save
      flash[:success] = t "micropost.flash.create_success"
      redirect_to root_url
    else
      # Neu create fail thi hien thi thong bao fail va loi validate
      # Dong thoi van hien thi cac micropost hien co
      @feed_items = current_user.feed.paginate page: params[:page],
        per_page: Settings.micropost.max_record_display
      flash[:danger] = t "micropost.flash.create_waning"
      render "static_pages/home"
    end
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t "micropost.flash.delete_success"
      # redirect_to request.referrer || root_url
      # hoac su dung: redicrect_back fallback_location:root_url
      redirect_back fallback_location: root_url
    else
      flash[:danger] = t "micropost.flash.delete_error"
      redirect_to root_url
    end
  end

  private

  def micropost_params
    params.require(:micropost).permit :content, :picture
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    unless @micropost
      flash[:danger] = t "micropost.flash.correct_user_to_delete_fails"
      redirect_to root_url
    end
  end
end
