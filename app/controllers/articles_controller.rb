class ArticlesController < ApplicationController
    before_action :require_user, except: [:index,:show]
    before_action :require_same_user, only: [:edit, :update, :destroy] 
    http_basic_authenticate_with name: "111", password: "111", except: [:index, :show]  

#new
    def new
        @article=Article.new
    end
#create
    def create
        @article = Article.new(article_params)

        @article.user=current_user 
       if @article.save
        redirect_to @article
       else
        render 'new'
       end
      end
#show 
      def show
        @article = Article.find(params[:id])
      end
#index
      def index
        @articles = Article.paginate(page: params[:page], per_page: 5)
      end
#edit
      def edit
        @article=Article.find(params[:id])
      end
#update
      def update
        @article = Article.find(params[:id])
       
        if @article.update(article_params)
          redirect_to @article
        else
          render 'edit'
        end
      end
 
      def destroy
        @article= Article.find(params[:id])
        @article.destroy

        redirect_to articles_path
      end

      private
        def article_params
            params.require(:article).permit(:title,:text, category_ids: [])
        end
        def require_same_user
          @article= Article.find(params[:id])
          if current_user != @article.user and !current_user.admin?
            flash[:danger]= "you can only edit and delete own articles"
            redirect_to root_path

        end
      end

end
