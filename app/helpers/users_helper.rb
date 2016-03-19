module UsersHelper
  def profile_thumb_url(user)
    if user.picture.url && user.picture.thumb.url
      user.picture.thumb.url
    else
      'user-thumb.png'
    end
  end

  def profile_pic_url(user)
    if user.picture.url
      user.picture.thumb.url
    else
      'user-icon.png'
    end    
  end
end
