
GOLDBERG_ROLES = {}
def load_goldberg_roles
  Goldberg::Role.find(:all, :select => 'id, name').each{|r| GOLDBERG_ROLES.update({r.name.downcase.to_sym => r.id})} rescue nil
end

GUEST_ROLE_ID = 2
module ActionController
  class Base
    def current_user
      begin
        @current_user ||= User.find(session[:goldberg][:user_id])
      rescue ActiveRecord::RecordNotFound => ex
        return nil
      end
    end

    def logged_in?
      ! current_user.nil?    
    end

    def create_guest(args = {})
      return if logged_in?
      attributes = {"name" => 'guest%i' % rand(100000), 
        "password" => Goldberg::User.random_password, 
        "role_id" => GUEST_ROLE_ID}
      attributes.update(args) if args.is_a?(Hash)
      return if current_user
      user = Goldberg.user = Goldberg::User.create(attributes)
      user.update_attribute :name, 'guest%i' % user.id if user.name =~ /^guest/
      Goldberg::AuthController.set_user(session, user.id)
    end
  end
end

module Goldberg
  class User
    validates_uniqueness_of :name, :unless => Proc.new {|record| record.name == 'guest' }
    
    def is_guest?
      name =~ /^guest/
    end
  end
end