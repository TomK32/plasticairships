class User < Goldberg::User
  has_many :sites
  has_many :posts
  has_many :comments
  
  def guest?
    self_reg_confirmation_required.nil?    
  end
  def moderator?
    self.role_id == GOLDBERG_ROLES[:moderator] || self.admin?
  end
  def admin?
    self.role_id == GOLDBERG_ROLES[:administrator]
  end
end
