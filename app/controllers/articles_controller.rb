class ArticlesController < ApplicationController
    before_action :set_article, only: [:edit, :update, :destroy]
    before_action :require_user, except: [:index, :show]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def index
        @articles = Article.paginate(page: params[:page])
    end
    def new
        @article = Article.new
    end
    def edit
    end
    def update
        if @article.update(article_params)
            redirect_to article_path(@article), flash: { success: "Article was successfully updated!" }
            return
        else
            render 'new'
             return
        end
    end
    def create
        @article = Article.new(article_params)
        @article.user = current_user
        if @article.save
            redirect_to article_path(@article), flash: { success: "Article was successfully created" }
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
            redirect_to articles_path, flash: { danger: "There is no post with the id #{params[:id]}" }
        end
    end
    def destroy
        @article.destroy
        redirect_to articles_path, flash: { success: "Article was successfully deleted" }
    end
    private
        def set_article
            @article = Article.find(params[:id])
        end
        def article_params
            params.require(:article).permit(:title, :description)
        end
        def require_same_user
            if current_user != @article.user && !current_user.admin?
                flash[:danger] = "Restricted to articles created on your own"
                redirect_to root_path
            end
        end
end