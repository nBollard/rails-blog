class ArticlesController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]

    def index
        @articles = Article.all
    end

    def show
        find_article
    end

    def new
        @article = Article.new
    end

    def edit
        find_article
    end

    def create
        @article = current_user.articles.create(article_params)
        if @article.save
            redirect_to @article
        else
            render 'new'
        end
    end

    def update
        find_article

        if @article.update(article_params)
            redirect_to @article
        else
            render 'edit'
        end
    end

    def destroy
        find_article

        @article.destroy
       
        redirect_to articles_path
    end

    private
    def find_article
        @article = Article.find(params[:id])
    end

    def article_params
        params.require(:article).permit(:title, :text)
    end
end
