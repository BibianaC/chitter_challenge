require 'bcrypt'

class User

  include DataMapper::Resource

  property :id,              Serial
  property :name,            String
  property :user_name,       String
  property :email,           String
  property :password_digest, Text

  has n, :peeps, :through => Resource

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

end