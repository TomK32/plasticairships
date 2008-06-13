class User < Goldberg::User
  has_many :sites, :dependent => :destroy
  has_many :posts, :dependent => :destroy
  has_many :comments, :dependent => :delete_all
  has_many :assets, :dependent => :delete_all
  has_many :bookmark_accounts, :dependent => :destroy
  
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
