class CommentsController < ApplicationController


  def create
    @admin = Admin.find(params[:article_id])
    @comment = @admin.comments.create(comment_params)
    redirect_to admin_path(@admin)
  end

  def destroy
    @admin = Admin.find(params[:article_id])
    @comment = @admin.comments.find(params[:id])
    @comment.destroy
    redirect_to admin_path(@admin)
  end

  private
  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end