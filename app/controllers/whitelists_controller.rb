class WhitelistsController < ApplicationController
  before_action :set_whitelist, only: [:show, :edit, :update, :destroy]

  # GET /whitelists
  # GET /whitelists.json

# Keyur Coded

    Elements_per_page1=10
    Elements_per_page2=10.0

# Keyur Coded End

  def index
    # @whitelists = Whitelist.all

# Keyur Coded

        @pagew = params.fetch(:page,0).to_i

        @whitelists = Whitelist.offset(@pagew*Elements_per_page1).limit(Elements_per_page1)
        @countw = Whitelist.all.count
        noOfpagew = (@countw/Elements_per_page1)
        @noOfPagesw = (@countw/Elements_per_page2)

        #@noOfPages=@noOfPages.ceil

        puts @noOfPagesw

        if @noOfPagesw/1 != @noOfPagesw.floor
            @noOfPagesw = noOfpagew
        else
            @noOfPagesw = noOfpagew-1
        end
        @currentPageNow = @pagew+1
        if @pagew<1
            @disabledPrevw=true
        else
            @disabledPrevw=false
        end

        if @pagew>@noOfPagesw-1
            @disabledNextw = true
        else
            @disabledNextw = false
        end

        #@lastNoOfPages=(@count/Elements_per_page).floor

#Keyur Coded End

  end

  # GET /whitelists/1
  # GET /whitelists/1.json
  def show
  end

  # GET /whitelists/new
  def new
    @whitelist = Whitelist.new
  end

  # GET /whitelists/1/edit
  def edit
  end

  # POST /whitelists
  # POST /whitelists.json
  def create
    @whitelist = Whitelist.new(whitelist_params)
    if @whitelist.save
      redirect_to whitelists_path, notice: 'Whitelist was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /whitelists/1
  # PATCH/PUT /whitelists/1.json
  def update
    if @whitelist.update(whitelist_params)
      redirect_to @whitelist, notice: 'Whitelist was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /whitelists/1
  # DELETE /whitelists/1.json
  def destroy
    @whitelist.destroy
    redirect_to whitelists_url, notice: 'Whitelist was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_whitelist
      @whitelist = Whitelist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def whitelist_params
      params.require(:whitelist).permit(:url, :name)
    end
end
