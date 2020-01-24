class ReviewForm
  include ActiveModel::Model
  include SpotifyMethod

  attr_accessor :artist_name, :album_name, :tags, :review_content, :user_id

  with_options presence: true do
    validates :artist_name
    validates :album_name
    validates :review_content
  end

  def save
    return false if invalid?

    artist_info = get_artist_spotify(artist_name)
    album_info = artist_info ? get_album_spotify(artist_info.id, album_name) : nil

    Review.transaction do
      artist = Artist.find_or_create_by!(name: artist_name, spotify_id: artist_info ? artist_info.id : nil)
      album = Album.find_or_create_by!(
        title: album_info ? album_info.name : album_name, 
        artist_id: artist.id, 
        spotify_id: album_info ? album_info.id : nil,
        image: album_info ? get_album_image(album_info.id) : 'no_image.png')
      review = Review.create!(
        content: review_content,
        user_id: user_id,
        album_id: album.id
      )
      if tags[0].present?
        tags.each do |tag|
          tag_record = Tag.find_or_create_by!(name: tag)
          ReviewsTag.create!(review_id: review.id, tag_id: tag_record.id)
        end
      end
    end
      true
    rescue => e
      puts e
      false
  end
end
