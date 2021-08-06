class AuthorsController < ApplicationController
  before_action :set_author, only: %i[ show edit update destroy ]

  # GET /authors or /authors.json
  def index
    @authors = User.left_joins(:books)
        .select('users.*, COUNT(books.id) as books_count')
        .group('users.id')
  end

  # GET /authors/1 or /authors/1.json
  def show
    @author = User.joins(books: :user)
        .select('books.id, books.title, books.published_at, users.name')
        # .joins(:authors).select('authors.name')
        .where("users.id = #{ params[:id] }")

        @count = User.joins('LEFT JOIN books ON users.id=books.user_id')
        .select('COUNT(books.id) as books_count').where("users.id = #{ params[:id] }")
  end

  # GET /authors/new
  def new
    @author = User.new
  end

  # GET /authors/1/edit
  def edit
  end

  # POST /authors or /authors.json
  def create
    @author = User.new(author_params)

    respond_to do |format|
      if @author.save
        format.html { redirect_to @author, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @author }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /authors/1 or /authors/1.json
  def update
    respond_to do |format|
      if @author.update(author_params)
        format.html { redirect_to @author, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @author }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /authors/1 or /authors/1.json
  def destroy
    @author.destroy
    respond_to do |format|
      format.html { redirect_to authors_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_author
      @author = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def author_params
      params.fetch(:author, {})
    end
end
