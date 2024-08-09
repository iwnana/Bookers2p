class BooksController < ApplicationController
    def index
        @books = Book.all
        @bookn = Book.new
    end
    
    def show
        @book = Book.find(params[:id])
        @bookn = Book.new
        @user = @book.user
    end
    
    def create
        @bookn = Book.new(book_params)
        @bookn.user_id = current_user.id
        if @bookn.save
          flash[:notice] = 'You have created book successfully.'
          redirect_to book_path(@bookn.id)
        else
          @books = Book.all
          render :index
        end
    end
    
    def edit
        @book = Book.find(params[:id])
        if @book.user == current_user
            render :edit
        else
            redirect_to books_path
        end
    end
    
    def update
        @book = Book.find(params[:id])
        if @book.update(book_params)
          flash[:notice] = 'You have updated book successfully.'
          redirect_to book_path(@book.id)
        else
          render :edit
        end
    end
    
    def destroy
        book = Book.find(params[:id])
        book.destroy
        redirect_to books_path
    end
    
    private
    
    def book_params
        params.require(:book).permit(:title, :body)
    end
end
