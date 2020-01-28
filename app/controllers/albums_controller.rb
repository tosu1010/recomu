class AlbumsController < ApplicationController
  include SpotifyMethod
  def index
    @albums = Album.all.order(id: 'DESC').includes(:artist, :reviews).select { |album| album.reviews.count > 0 }
  end

  def show
    @review_form = ReviewForm.new
    @album = Album.includes(:artist, reviews: [:tags, :likes]).find(params[:id])
    @tracks = @album.spotify_id ? get_tracks(@album.spotify_id) : nil
    @comment = Comment.new
  end
end
