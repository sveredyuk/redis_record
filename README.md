This class allows one to store in and retrieve objects from Redis via ActiveRecord-like API

Example:

class Post < RedisModel
  # Define all model attributes
  set_attributes :title, :body, :author

  # or
  # attribute :title
  # attribute :body
  # ...

  # ActiveMode::Validations are already included
  validates :title, :body, presence: true

  # Just define model_name for normal dispatching
  def self.model_name
    ActiveModel::Name.new(self, nil, "Post")
  end
end


In action:

post = Post.new # => #<Post:0x007fa8362f0dd8 @attributes={:title=>nil, :body=>nil, :author=>nil}>
post.save       # => false
post.valid?     # => false
post.errors     # => ... all errors

post.title  = 'My Post'   # => "My Post"
post.body   = 'Lorem....' # => "Lorem..."
post.author = 'God'       # => "God"
post.id                   # => "f6f0afbc2e790098cb2b" id for free from SecureRandom.hex(10)

post.valid? # => true
post.save   # => true

Post.all # => [ #<Post:0x007fa4212f0ab8 @attributes={"title"=>"My Post", "body"=>"Lorem....", "author"=>"God", "id"=>"f6f0afbc2e790098cb2b"}> ]
# .all return an Array of objects

Post.find('f6f0afbc2e790098cb2b') #=> Find record by id

Post.find_by(:title, 'My Post') # => Find first record with value of such attribute

Post.destroy_all # => Destroy all records from Redis

Additional:

post.attributes # => all attributes with values
post.update(title: 'Second Post') # => Update object (and save it)
post.unique?(:title) # Check about uniquness for some attribiute
post.destroy # => delete record from Redis.... bye

Post.redis # => #<Redis client v3.2.1 for redis://127.0.0.1:6379/0>

Post.key('f6f0afbc2e790098cb2b') # => "Post:f6f0afbc2e790098cb2b"

Post.attributes # => get all colums list

ActiveModel::Serializers available
post.to_json
post.to_xml
