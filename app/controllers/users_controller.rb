class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @buckets = @user.buckets.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      slack_notice_register_user(@user)
      flash[:success] = "登録完了しました！"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "プロフィールの変更を保存しました"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def all
    @user = User.find(params[:id])
    @buckets = @user.buckets.paginate(page: params[:page])
    render 'show'
  end

  def accomplished
    @user = User.find(params[:id])
    @buckets = @user.buckets.where(is_accomplished: true).paginate(page: params[:page])
    render 'show'
  end

  def unaccomplished
    @user = User.find(params[:id])
    @buckets = @user.buckets.where(is_accomplished: false).paginate(page: params[:page])
    render 'show'
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

end
