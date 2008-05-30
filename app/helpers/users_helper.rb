module UsersHelper
  def gravatar(email, alt="", size=50)
    return '' unless email
    url = "http://www.gravatar.com/avatar.php?size=#{size}&gravatar_id=#{Digest::MD5.hexdigest(email)}&default=http://%s%s" % [request.host_with_port, image_path('gravatar.jpg')]

    image_tag url, :size => "#{size}x#{size}", :alt => alt
  end
end
