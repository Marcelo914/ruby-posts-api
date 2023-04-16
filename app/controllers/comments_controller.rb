class CommentsController < ApplicationController
  before_action :load_post
  before_action :load_comment, only: %i[ show update destroy ]

  # GET /comments
  def index
    @comments = @post.comments

    render json: @comments
  end

  # GET /comments/1
  def show
    render json: @comment
  end

  # POST /comments
  def create
    @comment = @post.comments.new(comment_params)

    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def load_comment
      @comment = @post.comments.find(params[:id])
    end

    def load_post
      @post = Post.find(params[:post_id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.permit(:author, :content)
    end
end


