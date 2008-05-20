class User < Goldberg::User
  has_many :sites
  has_many :posts
  has_many :comments
  
  def guest?
    self_reg_confirmation_required.nil?    
  end
end
