class User < Goldberg::User
  has_many :sites
  has_many :posts
  has_many :comments
  has_many :assets
  
  def guest?
    self.role.name.downcase == 'guest'
  end
  def member?
    self.role.name.downcase == 'member' || self.moderator?
  end
  def moderator?
    self.role.name.downcase == 'moderator' || self.admin?
  end
  def admin?
    self.role.name.downcase == 'administrator'
  end
end
