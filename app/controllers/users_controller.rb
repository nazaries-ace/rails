class UsersController < ApplicationController
    def index
        @users = User.paginate(page: params[:page])
    end
    def new
        @user = User.new
    end
    def create
        @user = User.new(user_params)
        if @user.save
            flash[:success] = "Welcome to the Alpha Blog #{@user.username}"
            redirect_to articles_path
        else
            render 'new'
        end
    end
    def edit
        @user = User.find(params[:id])
    end
    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            flash[:success] = "User updated successfully"
            redirect_to articles_path
        else
            render 'new'
        end
        
    end
    def show
        @user = User.find(params[:id])
        @user_articles = @user.articles.paginate(page: params[:page])
        @user_articles.per_page = 2

    end

    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
end