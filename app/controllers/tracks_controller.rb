class TracksController < ApplicationController
  def index
    @tracks = Track.all
    render :index
  end

  def show
    @track = Track.find(params[:id])
    render :show
  end

  def new
    @track = Track.new
    @track.album_id = params[:album_id]
    render :new
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def edit
    @track = Track.find(params[:id])
    render :edit
  end

  def update
    @track = Track.find(params[:id])
    if @track.update_attributes(track_params)
      redirect_to track_url(@track)
    else
      render :edit
    end
  end

  def destroy
    Track.destroy(params[:id])
    redirect_to tracks_url
  end

  private

  def track_params
    params.require(:track).permit([:album_id, :name, :lyrics, :variety])
  end
end
