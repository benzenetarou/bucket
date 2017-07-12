class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @bucket = current_user.buckets.build if logged_in?
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def Contact
  end

end
