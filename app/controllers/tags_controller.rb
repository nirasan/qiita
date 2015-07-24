class TagsController < ApplicationController
  before_action :authenticate_user!, only:[:follow, :unfollow]
  before_action :set_tag, only: [:show]

  def show
  end

  def follow
    respond_to do |format|
      if Tag.follow(current_user, @tag)
        format.html { redirect_to @tag, notice: 'フォローしました。' }
      else
        format.html { redirect_to @tag, alert: 'フォローできませんでした。' }
      end
    end
  end

  def unfollow
    respond_to do |format|
      if Tag.unfollow(current_user, @tag)
        format.html { redirect_to @tag, notice: 'フォロー解除しました。' }
      else
        format.html { redirect_to @tag, alert: 'フォロー解除できませんでした。' }
      end
    end
  end

  private
  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:body)
  end

end
