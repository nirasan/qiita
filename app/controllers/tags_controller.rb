class TagsController < ApplicationController
  before_action :authenticate_user!, only:[:follow, :unfollow]
  before_action :set_tag, only: [:show, :edit, :update, :destroy, :follow, :unfollow]

  def index
    @tags = Tag.all
  end

  def show
  end

  def new
    @tag = Tag.new
  end

  def edit
  end

  def create
    @tag = Tag.new(tag_params)

    respond_to do |format|
      if @tag.save
        format.html { redirect_to @tag, notice: 'Tag was successfully created.' }
        format.json { render :show, status: :created, location: @tag }
      else
        format.html { render :new }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @tag.update(tag_params)
        format.html { redirect_to @tag, notice: 'Tag was successfully updated.' }
        format.json { render :show, status: :ok, location: @tag }
      else
        format.html { render :edit }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tag.destroy
    respond_to do |format|
      format.html { redirect_to tags_url, notice: 'Tag was successfully destroyed.' }
      format.json { head :no_content }
    end
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
