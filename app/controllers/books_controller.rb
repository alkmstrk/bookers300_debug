class BooksController < ApplicationController

  before_action :authenticate_user!

  before_action :current_user_check, only: [:edit, :update]

  def index
    @books = Book.all
    @book = Book.new
  end

  def show
    @book = Book.new
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: 'Book was successfully created.'
    else
      @book = Book.new
      @books = Book.all
      render :edit
    end
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book), notice: 'Book was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @book.destroy
      redirect_to books_path, notice: 'Book was successfully destroyed.'
    else
      redirect_to book_path(@book), notice: 'error destroyed.'
    end
  end

  private


  def book_params
    params.require(:book).permit(:title, :body)
  end


  def current_user_check
    @book = Book.find(params[:id])
    if current_user != @book.user
      redirect_to books_path
    end
  end

end
