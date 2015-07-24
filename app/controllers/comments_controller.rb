class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_entry
  before_action :set_comment, only: [:edit, :update, :destroy]

  def new
    @comment = Comment.new
  end

  def edit
  end

  def create
    @comment = @entry.comments.build(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @entry, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @entry }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @entry, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @entry, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_entry
    @entry = Entry.find(params[:entry_id])
  end

  def set_comment
    @comment = @entry.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
