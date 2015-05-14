class BandsController < ApplicationController
  before_action :redirect_if_not_logged_in

  def index
    @bands = Band.all.includes(:albums)
  end

  def new
    @band = Band.new
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      flash[:success] = "Band #{@band.name} created!"
      redirect_to band_url(@band)
    else
      flash[:errors] = @band.errors.full_messages
      render :new
    end
  end

  def edit
    @band = Band.find(params[:id])
  end

  def update
    @band = Band.find(params[:id])
    if @band.update(band_params)
      flash[:success] = "#{@band.name} updated!"
      redirect_to band_url(@band)
    else
      flash[:errors] = @band.errors.full_messages
      render :edit
    end
  end

  def show
    @band = Band.find(params[:id])
    @albums = @band.albums
  end

  def destroy
    band = Band.find(params[:id])
    band.destroy!
    flash[:success] = "Band #{band.name} deleted."
    redirect_to bands_url
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end
end
