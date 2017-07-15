class BucketsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: [:destroy, :accomplish]

  def show
    @buckets = Bucket.all.reverse_order.paginate(page: params[:page], :per_page => 100)
  end

  def create
    @bucket = current_user.buckets.build(bucket_params)
    if @bucket.save
      flash[:success] = "新しいリストを登録しました"
      notifier = Slack::Notifier.new "#{ENV['SLACK_WEBHOOK_URL']}", channel: "#bucket_notifier", username: "notifier"
      notifier.ping("追加されたリスト: " + @bucket.content)
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

  def accomplish
    @bucket.is_accomplished = "ture"
    @bucket.comment = "　→達成済み！"
    if @bucket.save
      redirect_to request.referrer || root_url
    else
      flash[:danger] = "更新に失敗しました"
    end
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
