class AlbumsController < ApplicationController
  def index
    @albums = Album.all
  end

  def show
    @album = Album.find(params[:id])
    @reviews = @album.reviews
    @another_albums = @album.another_albums()
  end
end
