class UrlsController < ApplicationController
  before_action :set_url, only: %i[ show destroy ]

  # GET /urls or /urls.json
  def index
    @urls = Url.all
  end

  # GET /urls/1 or /urls/1.json
  def show
  end

  # GET /urls/new
  def new
    @url = Url.new
  end

  # # GET /urls/1/edit
  # def edit
  # end

  # POST /urls or /urls.json
  def create
    @url = Url.new(url_params)
    ActiveRecord::Base.transaction do
      unless Key.any?
        @url.errors.add(:base, "No available keys to assign. Please try again later.")
        raise ActiveRecord::Rollback
      end
      key = Key.offset(rand(Key.count)).first
      @url.shortened = key.name
      if @url.save
        key.destroy!
        redirect_to @url, notice: "Url was successfully created."
        return
      else
        @url.errors.add(:base, "Failed to save the URL. Please check your input.")
        raise ActiveRecord::Rollback
      end
    end
    render :new, status: :unprocessable_entity
  end

  # # PATCH/PUT /urls/1 or /urls/1.json
  # def update
  #   respond_to do |format|
  #     if @url.update(url_params)
  #       format.html { redirect_to @url, notice: "Url was successfully updated." }
  #       format.json { render :show, status: :ok, location: @url }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @url.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /urls/1 or /urls/1.json
  def destroy
    @url.destroy!

    respond_to do |format|
      format.html { redirect_to urls_path, status: :see_other, notice: "Url was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # def go_to_original
  #   @url = Url.find_by(shortened: params[:path])
  #   redirect_to @url.original, allow_other_host: true
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_url
      @url = Url.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def url_params
      params.expect(url: [ :original ])
    end
    def create_url_with_key(url_params)
      url = Url.new(url_params)

      ActiveRecord::Base.transaction do
        raise ActiveRecord::RecordNotFound, "No available keys" unless Key.any?
        key = Key.offset(rand(Key.count)).first

        url.shortened = key.name
        key.destroy!
        url.save!
      end

      url
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotFound => e
      # Handle errors (e.g., log or re-raise for the caller to handle)
      Rails.logger.error "Transaction failed: #{e.message}"
      nil
    end
end
