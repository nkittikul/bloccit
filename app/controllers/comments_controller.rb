class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
    authorize @comment
  end

  def create
    @post = Post.find(params[:post_id])
    @topic = Topic.find(params[:topic_id])
    @comment = current_user.comments.build(comment_params)
    @comment.post = @post
    @comments = @post.comments.paginate(page: params[:page], per_page: 10)

    authorize @comment
     if @comment.save
      redirect_to [@topic, @post], notice: "Comment was saved successfully."
    else
      flash[:error] = "There was an error saving the comment. Please try again."
      render "posts/show"
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
