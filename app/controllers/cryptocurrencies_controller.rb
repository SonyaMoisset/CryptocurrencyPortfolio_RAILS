class CryptocurrenciesController < ApplicationController
  before_action :set_cryptocurrency, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :correct_user, only: [:show, :edit, :update, :destroy]

  # GET /cryptocurrencies
  # GET /cryptocurrencies.json
  def index
    @cryptocurrencies = Cryptocurrency.all

    require 'net/http'
    require 'json'

    @url = 'https://api.coinmarketcap.com/v1/ticker/'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @lookup_crypto = JSON.parse(@response)

    @profit_loss = 0
  end

  # GET /cryptocurrencies/1
  # GET /cryptocurrencies/1.json
  def show
  end

  # GET /cryptocurrencies/new
  def new
    @cryptocurrency = Cryptocurrency.new
  end

  # GET /cryptocurrencies/1/edit
  def edit
  end

  # POST /cryptocurrencies
  # POST /cryptocurrencies.json
  def create
    @cryptocurrency = Cryptocurrency.new(cryptocurrency_params)

    respond_to do |format|
      if @cryptocurrency.save
        format.html { redirect_to @cryptocurrency, notice: 'Cryptocurrency was successfully created.' }
        format.json { render :show, status: :created, location: @cryptocurrency }
      else
        format.html { render :new }
        format.json { render json: @cryptocurrency.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cryptocurrencies/1
  # PATCH/PUT /cryptocurrencies/1.json
  def update
    respond_to do |format|
      if @cryptocurrency.update(cryptocurrency_params)
        format.html { redirect_to @cryptocurrency, notice: 'Cryptocurrency was successfully updated.' }
        format.json { render :show, status: :ok, location: @cryptocurrency }
      else
        format.html { render :edit }
        format.json { render json: @cryptocurrency.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cryptocurrencies/1
  # DELETE /cryptocurrencies/1.json
  def destroy
    @cryptocurrency.destroy
    respond_to do |format|
      format.html { redirect_to cryptocurrencies_url, notice: 'Cryptocurrency was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cryptocurrency
      @cryptocurrency = Cryptocurrency.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cryptocurrency_params
      params.require(:cryptocurrency).permit(:symbol, :user_id, :cost_per, :amount_owned)
    end
    
    def correct_user
      @correct = current_user.cryptocurrencies.find_by(id: params[:id])
      redirect_to cryptocurrencies_path, notice: "Not Authorised to edit this entry" if @correct.nil?
    end
end
