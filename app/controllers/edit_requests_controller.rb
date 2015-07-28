class EditRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_entry
  before_action :set_edit_request, only: [:show, :destroy, :edit_apply, :update_apply, :apply]

  def index
    @edit_requests = @entry.edit_requests
  end

  def show
  end

  def new
    @edit_request = EditRequest.new
    @edit_request.body = @entry.body
  end

  def create
    @edit_request = @entry.edit_requests.build(edit_request_params)
    @edit_request.user = current_user
    @edit_request.old_body = @entry.body

    respond_to do |format|
      if @edit_request.save
        format.html { redirect_to @entry, notice: '編集リクエストを送信しました' }
        format.json { render :show, status: :created, location: @edit_request }
      else
        format.html { render :new }
        format.json { render json: @edit_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    unless @edity_request.user == current_user || @entry.user == current_user
      head 403
    end
    @edit_request.destroy
    respond_to do |format|
      format.html { redirect_to @entry, notice: '編集リクエストを削除しました' }
      format.json { head :no_content }
    end
  end

  def edit_apply
    # edit_request の old_body と body でパッチの作成
    # パッチを entry.body にあてる
    # 成功したらそのままフォームの body にセットして編集
    @body = params[:body]
    if @body.blank?
      @body, result = EditRequest.make_patched_body(@entry, @edit_request)
      unless result
        @body = EditRequest.create_premerged_body(@entry, @edit_request)
      end
    end
  end

  def update_apply
    # params[:body] を受け取り、entry.body の更新
    # edit_request を削除
    # 成功したら entry_path へ
    # 失敗したら edit_apply のレンダー
    respond_to do |format|
      if EditRequest.apply_patched_body(@entry, @edit_request, params[:body])
        format.html { redirect_to @entry, notice: '編集リクエストを適用しました' }
        format.json { render :show, status: :created, location: @edit_request }
      else
        format.html { render :edit_apply }
        format.json { render json: @edit_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def apply
    # edit_request の old_body と body でパッチの作成
    new_body, result = EditRequest.make_patched_body(@entry, @edit_request)
    if result
      # パッチを entry.body にあてる
      # edit_request を削除
      # 成功したら entry_path へ
      respond_to do |format|
        if EditRequest.apply_patched_body(@entry, @edit_request, new_body)
          format.html { redirect_to @entry, notice: '編集リクエストを適用しました' }
          format.json { render :show, status: :created, location: @edit_request }
        else
          format.html { redirect_to @entry, notice: '編集リクエストを適用できませんでした' }
          format.json { render json: @edit_request.errors, status: :unprocessable_entity }
        end
      end
    else
      # 失敗したら edit_apply へ
      redirect_to edit_apply_entry_edit_request_path(@entry, @edit_request)
    end
  end

  private
  def set_entry
    @entry = Entry.find(params[:entry_id])
  end

  def set_edit_request
    @edit_request = @entry.edit_requests.find(params[:id])
  end

  def edit_request_params
    params.require(:edit_request).permit(:title, :body)
  end
end
