module ApplicationHelper
  def profile_img(user)
    return image_tag(user.avatar, alt: user.name) if user.avatar?

    unless user.provider.blank?
      img_url = user.image_url
    else
      img_url = "no_image.png"
    end
    image_tag(img_url, alt: user.name)
  end

  def picture_img(picture)
    if picture.image?
      image_tag(picture.image, alt: picture.title) if picture.image?
    else
      image_tag("no_image.png", alt: "no_image")
    end
  end
end
