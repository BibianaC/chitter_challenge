require_relative 'user'

class Peep

  include DataMapper::Resource

  property :id,        Serial
  property :content,   Text
  property :timestamp, Time

  belongs_to :user

end
