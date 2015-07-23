class EntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_entry, only: [:show, :edit, :update, :destroy, :stock, :unstock]

  def index
    @entries = Entry.all
  end

  def show
  end

  def new
    @entry = Entry.new
  end

  def edit
  end

  def create
    @entry = Entry.new(entry_params)
    @entry.user = current_user

    respond_to do |format|
      if @entry.save
        format.html { redirect_to @entry, notice: 'Entry was successfully created.' }
        format.json { render :show, status: :created, location: @entry }
      else
        format.html { render :new }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to @entry, notice: 'Entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to entries_url, notice: 'Entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def stock
    respond_to do |format|
      if Entry.stock(current_user, @entry)
        format.html { redirect_to @entry, notice: 'ストックしました。' }
      else
        format.html { redirect_to @entry, alert: 'ストックできませんでした。' }
      end
    end
  end

  def unstock
    respond_to do |format|
      if Entry.unstock(current_user, @entry)
        format.html { redirect_to @entry, notice: 'ストック解除しました。' }
      else
        format.html { redirect_to @entry, alert: 'ストック解除できませんでした。' }
      end
    end
  end

  def preview
    @body = params['body']
    respond_to do |format|
      format.js
    end
  end

  private
  def set_entry
    @entry = Entry.find(params[:id])
  end

  def entry_params
    params.require(:entry).permit(:title, :body, :tag_string)
  end
end
