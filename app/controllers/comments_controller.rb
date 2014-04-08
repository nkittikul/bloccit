class CommentsController < ApplicationController
  respond_to :html, :js
  
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
      render "topics/posts/show"
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])

    @comment = @post.comments.find(params[:id])
    authorize @comment

    if @comment.destroy
      flash[:notice] = "Comment was removed."
    else
      flash[:error] = "Comment couldn't be deleted. Try again."
    end

    respond_with(@comment) do |f|
      f.html { redirect_to [@topic, @post] }
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
