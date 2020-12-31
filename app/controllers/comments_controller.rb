class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to ads_path(@comment.ad), notice: 'Komentar uspješno dodan!'
    else
      render location: ad_path(@comment.ad), error: 'Problem sa spremanjem komentara'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:ad_id, :name, :body)
  end
end
