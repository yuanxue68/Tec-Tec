module CommentsHelper
  def is_owner(comment)
    current_user == comment.user
  end
end
