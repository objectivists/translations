# Manages the "Book" model
class BooksController < AdminController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    @books = Book.all
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/slug
  # PATCH/PUT /books/slug.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/slug
  # DELETE /books/slug.json
  def destroy
    @book.destroy
    respond_to do |format|
      if @book.destroyed?
        format.html { redirect_to books_url, notice: 'Book was successfully deleted.' }
        format.json { head :no_content }
      else
        format.html { redirect_to books_url, notice: 'Book could not be deleted. Make sure it is not being used
          elsewhere (e.g., if there is a translation for the book, the book cannot be deleted).' }
        format.json { render json: @book.errors, status: :conflict }
      end

    end
  end

  private
    def set_book
      @book = Book.find_by_slug(params[:id])
    end

    # Whitelist params
    def book_params
      params.require(:book).permit(:title, :cover_image_url, :author, :slug)
    end
end
