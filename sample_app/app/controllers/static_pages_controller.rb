class StaticPagesController < ApplicationController
  def home
    if logged_in?
      # The first, defined @micropost
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate page: params[:page],
        per_page: Settings.micropost.max_record_display
    end
  end

  def help; end

  def about; end

  def contact; end
end
