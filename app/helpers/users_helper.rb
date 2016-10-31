module UsersHelper
  def gravatar_for(user, **args)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    size = args[:size] || 100
    image_tag(gravatar_url, alt: user.name, class: 'gravatar', width:size, height:size)
  end

end
