require 'digest/sha1'

class User < ActiveRecord::Base
    validates_presence_of :name
    validates_uniqueness_of :email
    validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
    attr_accessor :password_confirmation
    validates_confirmation_of :password
    
    has_one :library
    has_many :favorite
    
    def self.authenticate(email, password)
      user = self.find_by_email(email)
      if user
        expected_password = encrypt_password(password, user.salt)
        if user.hashed_password != expected_password
          user = nil
        end
      end
      return user
    end
    
    def gravatar 
        gravatar_id = Digest::MD5.hexdigest( email ) 
        "http://www.gravatar.com/avatar/#{ gravatar_id }?d=monsterid" 
    end
    
    def password
      @password
    end
    
    def password=(pwd)
      @password = pwd
      create_new_salt
      self.hashed_password = User.encrypt_password(self.password, self.salt)
    end
    
    private
    def self.encrypt_password(password, salt)
      string_to_hash = password + "rohit" + salt
      Digest::SHA1.hexdigest(string_to_hash) 
    end
    
    def create_new_salt
      self.salt = self.object_id.to_s + rand.to_s
    end
    
end
