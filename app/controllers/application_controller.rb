class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
    end

    def slack_notice_register_bucket(bucket)
      notifier = Slack::Notifier.new "#{ENV['SLACK_WEBHOOK_URL']}", channel: "#bucket_notifier", username: "notifier"
      notifier.ping("新しくBucketが追加されました。\n ユーザー名: " + bucket.user.name + "\nBucket: " + bucket.content)
    end

    def slack_notice_register_user(user)
      notifier = Slack::Notifier.new "#{ENV['SLACK_WEBHOOK_URL']}", channel: "#bucket_notifier", username: "notifier"
      notifier.ping("新規ユーザー登録がありました。\nユーザー名:" + user.name + "\nメールアドレス: "+ @user.email)
    end

end
