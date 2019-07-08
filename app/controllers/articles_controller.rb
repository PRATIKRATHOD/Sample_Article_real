class ArticlesController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show, :destroy]
    
    http_basic_authenticate_with name: "111", password: "111", except: [:index, :show]    
#new
    def new
        @article=Article.new
    end
#create
    def create
        @article = Article.new(article_params)
        @article.user=User.first 
       if @article.save
        redirect_to @article
       else
        render 'new'
       end
      end
#show 
      def show
      end
#index
      def index
        @articles = Article.paginate(page: params[:page], per_page: 5)
      end
#edit
      def edit
      end
#update
      def update       
        if @article.update(article_params)
          redirect_to @article
        else
          render 'edit'
        end
      end
 
      def destroy
        @article.destroy
        redirect_to articles_path
      end

      private
        def article_params
            params.require(:article).permit(:title,:text)
        end
        def set_user
          @user=User.find(params[:id])
      end
end
