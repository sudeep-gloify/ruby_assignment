class LibrariesController < ApplicationController
  before_action :set_library, only: %i[ show edit update destroy ]

  # GET /libraries or /libraries.json
  def index
    @libraries = Library.left_joins(:books)
        .select('libraries.*, COUNT(books.id) as books_count')
        .group('libraries.id')
        # render json: @libraries
  end

  # GET /libraries/1 or /libraries/1.json
  def show
    @single_library = Library.find(params[:id])
    @library = Library.joins(books: :user)
        .select('books.id, books.title, books.published_at, users.name')
        # .joins(:authors).select('authors.name')
        .where("libraries.id = #{ params[:id] }")

        @count = Library.joins('LEFT JOIN books ON libraries.id=books.library_id')
        .select('COUNT(books.id) as books_count').where("libraries.id = #{ params[:id] }")
        # render json: @count
        @unassinged_books = Book.where(library_id: [nil, ""])
        # render json: @unassinged_books
  end

  # GET /libraries/new
  def new
    @library = Library.new
  end

  # GET /libraries/1/edit
  def edit
  end

  # POST /libraries or /libraries.json
  def create
    @library = Library.new(library_params)

    respond_to do |format|
      if @library.save
        format.html { redirect_to @library, notice: "Library was successfully created." }
        format.json { render :show, status: :created, location: @library }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /libraries/1 or /libraries/1.json
  def update
    respond_to do |format|
      if @library.update(library_params)
        format.html { redirect_to @library, notice: "Library was successfully updated." }
        format.json { render :show, status: :ok, location: @library }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /libraries/1 or /libraries/1.json
  def destroy
    @library.destroy
    respond_to do |format|
      format.html { redirect_to libraries_url, notice: "Library was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_library
      @library = Library.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def library_params
      params.require(:library).permit(:name, :opening_time, :closing_time)
    end
end
