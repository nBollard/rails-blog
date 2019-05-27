class CommentsController < ApplicationController
    http_basic_authenticate_with name: "dhh", password: "secret", only: :destroy

    def create
        find_article
        @comment = @article.comments.create(comment_params)
        redirect_to article_path(@article)
    end
     
    def destroy 
        find_article
        @comment = @article.comments.find(params[:id])
        @comment.destroy
        redirect_to article_path(@article)
    end

    private
    def find_article
        @article = Article.find(params[:article_id])
    end

    def comment_params
        params.require(:comment).permit(:commenter, :body)
    end
end
