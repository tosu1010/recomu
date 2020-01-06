class AlbumsController < ApplicationController
  include SpotifyMethod

  before_action :spotify_auth, only: :show

  def index
    @albums = Album.all.includes(:artist)
  end

  def show
    @album = Album.includes(:artist, reviews: :tags).find(params[:id])
    @tracks = @album.spotify_id ? get_tracks(@album.spotify_id) : nil
  end
end
