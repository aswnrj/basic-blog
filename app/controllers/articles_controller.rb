class ArticlesController < ApplicationController
  def show
    @article = Article.find(params[:id])
  end
  
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def edit 
    # render plain: params
    @article = Article.find(params[:id])
  end

  def update
    edited_article = params[:article]
    @article = Article.find(params[:id])
    @article[:title] = edited_article[:title]
    @article[:description] = edited_article[:description]
    @article.save
    redirect_to articles_path
  end

  def create
    @article = Article.new(params.require(:article).permit(:title, :description))
    if @article.valid? 
      @message = "Article saved succesfully"
    else 
      @message = "Not saved"
    end
    if @article.save
      flash[:notice] = "Article was created successfully."
      redirect_to article_path(@article)
    else
      render 'new'
    end    
  end
end