class LanguagesController < AdminController
  before_action :set_language, only: [:show, :edit, :update, :destroy]

  # GET /languages
  # GET /languages.json
  def index
    @languages = Language.all
  end

  # GET /languages/slug
  # GET /languages/slug.json
  def show
  end

  # GET /languages/new
  def new
    @language = Language.new
  end

  # GET /languages/slug/edit
  def edit
  end

  # POST /languages
  # POST /languages.json
  def create
    @language = Language.new(language_params)

    respond_to do |format|
      if @language.save
        format.html { redirect_to @language, notice: 'Language was successfully created.' }
        format.json { render :show, status: :created, location: @language }
      else
        format.html { render :new }
        format.json { render json: @language.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /languages/slug
  # PATCH/PUT /languages/slug.json
  def update
    respond_to do |format|
      if @language.update(language_params)
        format.html { redirect_to @language, notice: 'Language was successfully updated.' }
        format.json { render :show, status: :ok, location: @language }
      else
        format.html { render :edit }
        format.json { render json: @language.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /languages/slug
  # DELETE /languages/slug.json
  def destroy
    @language.destroy
    respond_to do |format|
      if @language.destroyed?
        format.html { redirect_to languages_url, notice: 'Language was successfully deleted.' }
        format.json { head :no_content }
      else
        format.html { redirect_to languages_url, notice: 'Language could not be removed. Make sure it is not being used
          elsewhere (e.g., if there is a translation to/from this language, the language cannot be removed).' }
        format.json { render json: @language.errors, status: :conflict }
      end
    end
  end

  private
    def set_language
      @language = Language.find_by_slug(params[:id])
    end

    # Whitelist params
    def language_params
      params.require(:language).permit(:name, :local_name, :slug)
    end
end
