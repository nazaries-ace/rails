class ArticlesController < ApplicationController
    before_action :set_article, only: [:edit, :update, :destroy]

    def index
        @articles = Article.all
    end
    def new
        @article = Article.new
    end
    def edit
    end
    def update
        if @article.update(article_params)
            redirect_to article_path(@article), notice: "Article was successfully updated!"
            return
        else
            render 'new'
             return
        end
    end
    def create
        @article = Article.new(article_params)
        if @article.save
            redirect_to article_path(@article), notice: "Article was successfully created"
            return
        else
            render 'new'
             return
        end
    end
    def show
        if Article.where(id: params[:id]).exists?(conditions = :none)
            set_article
        else
            redirect_to articles_path, notice: "There is no post with the id #{params[:id]}"
        end
    end
    def destroy
        @article.destroy
        redirect_to articles_path, notice: "Article was successfully deleted"
    end
    private
        def set_article
            @article = Article.find(params[:id])
        end
        def article_params
            params.require(:article).permit(:title, :description)
        end
end