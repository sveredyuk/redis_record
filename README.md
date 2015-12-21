# RedisRecord

Gem provide simple ORM for `redis/ruby/rails`.

## Description

You could easy operate with objects in `ActiveRecord/Mongoid` API like style.
The main goal was create 100% compatible API with rails controllers and be almost same like ActiveRecord API.

Try to generate simple scaffold with all MVC and than just change ActiveRecord model to RedisRecord (with all fields defined).
And try it! It great works!

Great thanks for inspiration and support to **Michael Lutsiuk** and all members of my team.

## Installation

After release, gem will be added to `rubygems`

Until please use github tag in you Gemfile:
```ruby
gem 'redis_record', github: 'svereredyuk/redis_record'
```

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

You could define the default value for field by `default` option.

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
Current library support next types:
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

Uniqueness validations meet some troubles such as it is part of `ActiveRecord::Validations` and depent on database adapter.

But you could use `#unique?` method:

```ruby
p.title = "Test"
p.save

new_post = Post.new(title: "Test")
new_post.unique?(:title) #=> false
```

`TODO: Add special uniqueness validator.`

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

For connection to Redis we use `Redis.current` from `redis-rb` lib.

```ruby
Post.reids #=> #<Redis client v3.2.2 for redis://127.0.0.1:6379/0>
```

Manage seetings in your `redis.yml`

## TODO

* Associations: belongs_to, has_many... etc
* Better uniqueness validator
* Callbacks
* Timestamps extension: created_at, updated_at
* Try to reproduce 100% ActiveRecord API.
