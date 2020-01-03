class AlbumsController < ApplicationController
  include SpotifyMethod

  before_action :spotify_auth, only: :show

  def index
    @albums = Album.all
  end

  def show
    @album = Album.find(params[:id])
    @tracks = @album.spotify_id ? get_tracks(@album.spotify_id) : nil
  end
end
