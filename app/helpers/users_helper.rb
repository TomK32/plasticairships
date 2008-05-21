module UsersHelper
  def gravatar(email, alt="", size=80, default=nil)
    return '' unless email
    url = "http://www.gravatar.com/avatar.php?size=#{size}&gravatar_id=#{Digest::MD5.hexdigest(email)}"
    url << "&default=#{default}" if default

    image_tag url, :class => 'gravatar', :size => "#{size}x#{size}", :alt => alt
  end
end
