class EditRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_entry
  before_action :set_edit_request, only: [:show, :edit, :update, :destroy]

  def index
    @edit_requests = @entry.edit_requests
  end

  def show
  end

  def new
    @edit_request = EditRequest.new
    @edit_request.body = @entry.body
    @edit_request.old_body = @entry.body
  end

  def edit
  end

  def create
    @edit_request = @entry.edit_requests.build(edit_request_params)
    @edit_request.user = current_user

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

  def update
    respond_to do |format|
      if @edit_request.update(edit_request_params)
        format.html { redirect_to @entry, notice: '編集リクエストを更新しました' }
        format.json { render :show, status: :ok, location: @edit_request }
      else
        format.html { render :edit }
        format.json { render json: @edit_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @edit_request.destroy
    respond_to do |format|
      format.html { redirect_to @entry, notice: '編集リクエストを削除しました' }
      format.json { head :no_content }
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
    params.require(:edit_request).permit(:title, :body, :old_body)
  end
end
