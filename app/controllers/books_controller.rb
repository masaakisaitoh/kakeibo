class BooksController < ApplicationController

  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    logger.debug('aaaaaaaaaaaaaaaaaaaa')
    @books = Book.all
    @books = @books.where(year: params[:year]) if params[:year].present?
    @books = @books.where(month: params[:month]) if params[:month].present?
  end

  def show
  end

  def new
    @book = Book.new
    @book.year = 2023
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:notice] = "家計簿にデータ#{book_params['year']}年#{book_params['month']}月#{book_params['category']}を登録しました"
      redirect_to books_path
    else
      flash.now[:alert] = "登録に失敗しました"   # うまくうごかない
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      flash[:notice] = "データを１件更新しました"
      #redirect_to books_path # 一覧画面
      redirect_to book_path(@book)  # 詳細画面
    else
      flash.now[:alert] = "更新に失敗しました"
      render :edit
    end
  end

  def destroy
    @book.destroy
    flash[:notice] = "削除しました"
    redirect_to books_path
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    #    book_params = params.require(:book).permit(:year, :month, :inout, :category, :amount)
    params.require(:book).permit(:year, :month, :inout, :category, :amount)
  end

end
