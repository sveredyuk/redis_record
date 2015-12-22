# RedisRecord

Gem provides simple ORM for `redis/ruby/rails`.

## Description

You could easy operate with objects in `ActiveRecord/Mongoid` API like style.
The main goal is to create 100% compatible API with rails controllers and maximum simular ActiveRecord API.

Try to generate simple MVC scaffoldand just change ActiveRecord model to RedisRecord (with all fields defined).
And try it! It works great!

Great thanks for inspiration and support to **Michael Lutsiuk** and all members of my team.

## Installation & Setup

After release, gem will be added to `rubygems`

Until please use github tag in your Gemfile:
```ruby
gem 'redis_record', git: 'git@github.com:sveredyuk/redis_record.git'
```

You can use generator:
```ruby
rails generate redis_record
```
This will create: config/initializers/redis_record.rb
```ruby
RedisRecord::Config.namespace = 'RedisRecord_6822b3923f'
```
**Be careful with changing namespace, it will be create new empty closet for your data.**

## Example
```ruby
class Post < RedisRecord::Base
  field: :title
  field: :body,         type: String
  field: :rank,         type: Integer
  field: :featured,     type: Bool     default: false
  field: :published_at, type: Time,    default: Time.now
end
```

Define single `field` with some type (String is default if type not defined) or multiple `fields` for attributes with identical type.

```ruby
fields: title, :body, :author, type: String
```

You could define the default value of field using `default` option.

Field's type depent at value assign and parse when call:

```ruby
p = Post.new
p.title = "The best post ever"
p.featured = true
p.save          #=> true

p.title         #=> "The best post ever"
p.featured      #=> true

p.rank          #=> nil
p.rank = "rank" #=> RuntimeError: WrongFormat: value must be Integer
p.rank = 5
p.rank          #=> 5

p.update(title: "New title") #=> true
p.title         #=> "New title"

p.destroy       #=> true
p.reload        #=> nil
```

## Field Types
Current version of gem support few types:
* String (by default if not defined)
* Integer
* Float
* Bool (old good Boolean)
* Array
* Hash
* Time (DateTime in fact)

## Validations

Out of the box you have all `ActiveModel::Validations`

in model:
```ruby
validates :title, presence: true
```
and:

```ruby
p = Post.new
p.save    #=> false
p.valid?  #=> false
p.errors  #=> {:title=>["can't be blank"]}
p.title = "Blah"
p.valid?  #=> true
p.save    #=> true
```

Uniqueness validations meet some troubles such as it's part of `ActiveRecord::Validations` and depent on database adapter. But you could use `#unique?` method:

```ruby
p.title = "Test"
p.save

new_post = Post.new(title: "Test")
new_post.unique?(:title) #=> false
```

## Serializations

Also included `ActiveModel::Serializers::JSON` and `ActiveModel::Serializers::Xml`

## Associations

``` ruby
# TODO: WIP!
```

## Callbacks


``` ruby
# TODO: WIP!
```

## Connection

For connection to Redis we use `Redis.new` from `redis-rb` lib.

```ruby
Post.reids #=> #<Redis client v3.2.2 for redis://127.0.0.1:6379/0>
```

You could manage connection seetings in your `redis.yml` file.

## TODO

* Associations: belongs_to, has_many... etc
* Better uniqueness validator
* Callbacks
* Timestamps extension: created_at, updated_at
* Try to reproduce 100% ActiveRecord API.
