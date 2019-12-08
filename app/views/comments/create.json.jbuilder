json.id @comment.id
json.(@comment, :comment)
json.user_name @comment.user.nickname
json.created_at I18n.l(@comment.created_at, format: :short)