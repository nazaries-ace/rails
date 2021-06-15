class WelcomeController < ApplicationController
    def index
        if logged_in?
            redirect_to articles_path
        else
            render 'index'
        end
    end
end
