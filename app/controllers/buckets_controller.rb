class BucketsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @bucket = current_user.buckets.build(bucket_params)
    if @bucket.save
      flash[:success] = "新しいリストを登録しました"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
    @bucket.destroy
    flash[:success] = "Bucketを削除しました"
    redirect_to request.referrer || root_url
  end

  private

  def bucket_params
    params.require(:bucket).permit(:content)
  end

  def correct_user
    @bucket = current_user.buckets.find_by(id: params[:id])
    redirect_to root_url if @bucket.nil?
  end
end
