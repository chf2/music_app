class TracksController < ApplicationController
  before_action :redirect_if_not_logged_in
  before_action :admin_required, except: [:show]
  
  def new
    @track = Track.new
    @albums = Album.all
    @album_id = params[:album_id].to_i
  end

  def create
    @track = Track.new(track_params)
    @albums = Album.all
    if @track.save
      flash[:success] = "Added #{@track.name} to #{@track.album.name}!"
      redirect_to track_url(@track)
    else
      flash[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def show
    @track = Track.find(params[:id])
    @notes = @track.notes.includes(:user)
  end

  def edit
    @track = Track.find(params[:id])
    @albums = Album.all
  end

  def update
    @track = Track.find(params[:id])
    @albums = Album.all
    if @track.update(track_params)
      flash[:success] = "#{@track.name} updated!"
      redirect_to track_url(@track)
    else
      flash[:errors] = @track.errors.full_messages
      render :edit
    end
  end

  def destroy
    track = Track.find(params[:id])
    track.destroy!
    flash[:success] = "Track #{track.name} removed from #{track.album.name}"
    redirect_to album_url(track.album_id)
  end

  private

  def track_params
    params.require(:track).permit(:name, :lyrics, :album_id, :track_type)
  end

end
