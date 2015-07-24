class UsersController < ApplicationController
  before_action :authenticate_user!, only:[:follow, :unfollow]
  before_action :set_user

  def show
  end

  def follow
    respond_to do |format|
      if current_user.follow(@user)
        format.html { redirect_to @user, notice: 'フォローしました。' }
      else
        format.html { redirect_to @user, alert: 'フォローできませんでした。' }
      end
    end
  end

  def unfollow
    respond_to do |format|
      if current_user.unfollow(@user)
        format.html { redirect_to @user, notice: 'フォロー解除しました。' }
      else
        format.html { redirect_to @user, alert: 'フォロー解除できませんでした。' }
      end
    end
  end

  def entries
  end

  def stocks
  end

  def comments
  end

  def followers
  end

  def followees
  end

  def tags
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end
