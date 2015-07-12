# maybe.rb
[![Build Status](https://travis-ci.org/demonh3x/maybe.rb.svg?branch=master)](https://travis-ci.org/demonh3x/maybe.rb)
[![Code Climate](https://codeclimate.com/github/demonh3x/maybe.rb/badges/gpa.svg)](https://codeclimate.com/github/demonh3x/maybe.rb)
[![Test Coverage](https://codeclimate.com/github/demonh3x/maybe.rb/badges/coverage.svg)](https://codeclimate.com/github/demonh3x/maybe.rb/coverage)

A very simple [Option type](https://en.wikipedia.org/wiki/Option_type) implementation to avoid the problems of using nil:
* [http://www.infoq.com/presentations/Null-References-The-Billion-Dollar-Mistake-Tony-Hoare](http://www.infoq.com/presentations/Null-References-The-Billion-Dollar-Mistake-Tony-Hoare)
* [http://sortega.github.io/development/2013/07/13/nullitis/](http://sortega.github.io/development/2013/07/13/nullitis/)

You may argue that `nil` in ruby is not like `null` in other languages because it is an Object. I would say that `nil` breaks the [liskov substitution principle](http://c2.com/cgi/wiki?LiskovSubstitutionPrinciple). [Sandi Metz](https://twitter.com/sandimetz) explain it better than me: [http://www.sandimetz.com/blog/2014/12/19/suspicions-of-nil](http://www.sandimetz.com/blog/2014/12/19/suspicions-of-nil).

A common solution to that problem is using the [Null Object Pattern](http://refactoring.com/catalog/introduceNullObject.html). This is not a substitute for the Null Object Pattern. It adds a different way of dealing with the situations [when there is no result](http://blog.8thlight.com/uku-taht/2015/04/29/using-the-option-type-effectively.html). And it can be used in addition to the Null Object Pattern.

## Example

```ruby
require 'maybe'

class User
  attr_accessor :name
end

def find_user(id)
  if (id == 21)
    user = User.new
    user.name = "John"
    Maybe.this(user)
  else
    Maybe.nothing
  end
end

puts 'Introduce an id to look for:'
id = Integer(gets)

user = find_user(id)

puts user
  .change { |it| it.name }
  .or { "Not found" }
```

## Run tests
`rake`
