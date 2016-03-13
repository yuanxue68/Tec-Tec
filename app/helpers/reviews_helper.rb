module ReviewsHelper
  def is_review_giver(review)
    return current_user == review.giver
  end
end
