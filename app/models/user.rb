require 'bcrypt'

class User

  include DataMapper::Resource

  attr_reader :password
  attr_accessor :password_confirmation
  validates_confirmation_of :password

  property :id,              Serial
  property :name,            String
  property :user_name,       String
  property :email,           String, :unique => true, :message => "This email is already registered"
  property :password_digest, Text

  has n, :peeps, :through => Resource

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

end