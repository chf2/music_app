class AlbumsController < ApplicationController
  before_action :redirect_if_not_logged_in
  before_action :admin_required, except: [:show]

  def new
    @album = Album.new
    @bands = Band.all
    @band_id = params[:band_id].to_i
  end

  def create
    @album = Album.new(album_params)
    @bands = Band.all
    if @album.save
      flash[:success] = "Album #{@album.name} Created!"
      redirect_to album_url(@album)
    else
      flash[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def show
    @album = Album.find(params[:id])
    @tracks = @album.tracks
  end

  def edit
    @album = Album.find(params[:id])
    @bands = Band.all
  end

  def update
    @album = Album.find(params[:id])
    @bands = Band.all
    if @album.update(album_params)
      flash[:success] = "#{@album.name} updated!"
      redirect_to album_url(@album)
    else
      flash[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  def destroy
    album = Album.find(params[:id])
    album.destroy
    flash[:success] = "Removed #{album.name}."
    redirect_to :root
  end

  def album_params
    params.require(:album).permit(:name, :band_id, :album_type)
  end
end
