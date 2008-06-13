
module ActionController
  class Base
    def current_user
      return false unless session[:goldberg]
      begin
        @current_user ||= User.find(session[:goldberg][:user_id])
      rescue ActiveRecord::RecordNotFound => ex
        return false
      end
    end
    alias :logged_in? :current_user

    def create_guest(args = {})
      return if logged_in?
      attributes = {"name" => 'guest%i' % rand(100000), 
        "password" => Goldberg::User.random_password, 
        "role_id" => Goldberg::Role.find_by_name('Guest', :select => :id).id}
      attributes.update(args) if args.is_a?(Hash)
      return if current_user
      user = Goldberg.user = Goldberg::User.create!(attributes)
      user.update_attribute :name, 'guest%i' % user.id if user.name =~ /^guest/
      Goldberg::AuthController.set_user(session, user.id)
      user
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