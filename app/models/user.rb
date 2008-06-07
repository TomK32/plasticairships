class User < Goldberg::User
  has_many :sites
  has_many :posts
  has_many :comments
  has_many :assets
  
  def guest?
    self.role_id == GOLDBERG_ROLES[:guest]
  end
  def member?
    self.role_id == GOLDBERG_ROLES[:member] || self.moderator?    
  end
  def moderator?
    self.role_id == GOLDBERG_ROLES[:moderator] || self.admin?
  end
  def admin?
    self.role_id == GOLDBERG_ROLES[:administrator]
  end
end
