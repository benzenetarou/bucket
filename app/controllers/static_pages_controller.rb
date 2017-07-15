class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @bucket = current_user.buckets.build if logged_in?
      @feed_items = current_user.feed.paginate(page: params[:page], :per_page => 100)
    end
  end

  def help
  end

  def about
  end

  def Contact
  end

end
