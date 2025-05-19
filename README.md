# Ruby on Rails Tutorial sample application

This is the sample application for
[_Ruby on Rails Tutorial:
Learn Web Development with Rails_](https://www.railstutorial.org/)
(6th Edition)
by [Michael Hartl](https://www.michaelhartl.com/).

## License

All source code in the [Ruby on Rails Tutorial](https://www.railstutorial.org/)
is available jointly under the MIT License and the Beerware License. See
[LICENSE.md](LICENSE.md) for details.

## Getting started

To get started with the app, clone the repo and then install the needed gems:

```
$ bundle install --without production
```

Next, migrate the database:

```
$ rails db:migrate
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```

For more information, see the
[_Ruby on Rails Tutorial_ book](https://www.railstutorial.org/book).

# Answers [Chapter 4. Rails-Flavored Ruby]

## 4.3.2 Blocks

1. Using the range **`0..16`**, print out the first 17 powers of 2.

```ruby
(0..16).map do |power|
	2**power
end

(0..16).map { |power| 2**power }

=> [1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536]
```

2. Define a method called **`yeller`** that takes in an array of characters and returns a string with an ALLCAPS version of the input. Verify that **`yeller(['o', 'l', 'd'])`** returns **`"OLD"`**. *Hint*: Combine **`map`**, **`upcase`**, and **`join`**.

```ruby
def yeller(array)
	puts array.map(&:upcase).join
end

# or
def yeller(array)
  puts array.join.upcase
end
```

3. Define a method called **`random_subdomain`** that returns a randomly generated string of eight letters.

```ruby
def random_subdomain
  puts ('a'..'z').to_a.shuffle[0..7].join
end

# Convention
def random_subdomain
  puts ('a'..'z').to_a.sample(8).join
end
```

4. By replacing the question marks in Listing 4.12 with the appropriate methods, combine **`split`**, **`shuffle`**, and **`join`** to write a function that shuffles the letters in a given string.

_Listing 4.12_

```ruby
>> def string_shuffle(s)
>>   s.?('').?.?
>> end
>> string_shuffle("foobar")
=> "oobfra"
```

_Solution_

```ruby
def string_shuffle(s)
  s.split('').shuffle.join
end

puts string_shuffle("foobar")
```

## 4.3.3 \***\*Hashes and Symbols\*\***

1. Define a hash with the keys **`'one'`**, **`'two'`**, and **`'three'`**, and the values **`'uno'`**, **`'dos'`**, and **`'tres'`**. Iterate over the hash, and for each key-value pair print out **`"'#{key}' in Spanish is '#{value}'"`**.

```ruby
hash = { 'one' => 'uno', 'two' => 'dos', 'three' => 'tres'}

hash.each { |key, value| puts "'#{key}' in Spanish is '#{value}'" }
```

2. Create three hashes called **`person1`**, **`person2`**, and **`person3`**, with first and last names under the keys **`:first`** and **`:last`**. Then create a **`params`** hash so that **`params[:father]`** is **`person1`**, **`params[:mother]`** is **`person2`**, and **`params[:child]`** is **`person3`**. Verify that, for example, **`params[:father][:first]`** has the right value.

```ruby
person1 = { :first => 'Sam', :last => 'Smith' }
person2 = { :first => 'Kelly', :last => 'Smith' }
person3 = { :first => 'Brad', :last => 'Smith' }

params = {
  :father => person1,
  :mother => person2,
  :child => person3
}

puts params[:father][:first]

=> Sam
```

3. Define a hash with symbol keys corresponding to name, email, and a “password digest,” and values equal to your name, your email address, and a random string of 16 lowercase letters.

```ruby
def random_password
  ('a'..'z').to_a.shuffle[0..15].join
end

params = { name: 'Piter', email: 'piter@mail.com', password: random_password}

p params

=> {:name=>"Piter", :email=>"piter@mail.com", :password=>"oefzvnkjbuymrsac"}
```

4. Find an online version of the Ruby API and read about the Hash method **`merge`**
   . What is the value of the following expression?

[https://apidock.com/ruby/Hash/merge](https://apidock.com/ruby/Hash/merge)

```ruby
h1 = { "a" => 100, "b" => 200 }
h2 = { "b" => 254, "c" => 300 }
p h1.merge(h2)   #=> {"a"=>100, "b"=>254, "c"=>300}
p h2.merge(h1)   #=> {"b"=>200, "c"=>300, "a"=>100}
p h1.merge(h2){|key, oldval, newval| newval - oldval}
                 #=> {"a"=>100, "b"=>54,  "c"=>300}
p h1             #=> {"a"=>100, "b"=>200}
```

# \***\*4.4 Ruby Classes\*\***

## 4.4.1 \***\*Constructors\*\***

1. What is the literal constructor for the range of integers from 1 to 10?

```ruby
>> 1..10
=> 1..10

>> (1..10) == Range.new(1,10)
=> true
```

2. What is the constructor using the **`Range`** class and the **`new`** method? *Hint*: **`new`** takes two arguments in this context.

```ruby
>> Range.new(1,10)
=> 1..10
```

3. Confirm using the **`==`** operator that the literal and named constructors from the previous two exercises are identical.

```ruby
>> (1..10) == Range.new(1,10)
=> true
```

## 4.4.2 \***\*Class Inheritance\*\***

1. What is the class hierarchy for a range? For a hash? For a symbol?

```ruby
>> (1..10) == Range.new(1,10)
=> true
>> range = (1..10)
=> 1..10
>> range.class
=> Range
>> range.class.superclass
=> Object
>> range.class.superclass.superclass
=> BasicObject
```

```ruby
>> hash = {}
=> {}
>> hash.class
=> Hash
>> hash.class.superclass
=> Object
>> hash.class.superclass.superclass
=> BasicObject
```

```ruby
>> symbol = :symbol
=> :symbol
>> symbol.class
=> Symbol
>> symbol.class.superclass
=> Object
>> symbol.class.superclass.superclass
=> BasicObject
```

2. Confirm that the method shown in Listing 4.15 works even if we replace **`self.reverse`** with just **`reverse`**.

_Listing 4.15_

```ruby
>> class Word < String             # Word inherits from String.
>>   # Returns true if the string is its own reverse.
>>   def palindrome?
>>     self == self.reverse        # self is the string itself.
>>   end
>> end
=> nil
```

_Solution_

```ruby
class Word < String        # Word inherits from String.
  # Returns true if the string is its own reverse.
  def palindrome?
    self == reverse        # self is the string itself.
  end
end

str = Word.new('level')

p str.palindrome?
```

## 4.4.3 \***\*Modifying Built-in Classes\*\***

1. 1. Verify that “racecar” is a palindrome and “onomatopoeia” is not. What about the name of the South Indian language “Malayalam”? *Hint*: Downcase it first.

```ruby
class String
  # Returns true if the string is its own reverse.
  def palindrome?
    self == self.reverse
  end
end

p "racecar".palindrome?             #=> true
p "onomatopoeia".palindrome?        #=> false
p "Malayalam".downcase.palindrome?  #=> true

```

2. Using Listing 4.16 as a guide, add a **`shuffle`** method to the **`String`** class. *Hint*: Refer to Listing 4.12.

_Listing 4.16_

```ruby
>> class String
>>   def shuffle
>>     self.?('').?.?
>>   end
>> end
>> "foobar".shuffle
=> "borafo"
```

_Listing 4.12_

```ruby
>> def string_shuffle(s)
>>   s.?('').?.?
>> end
>> string_shuffle("foobar")
=> "oobfra"
```

_Solution_

```ruby
class String
  def shuffle
    self.split('').shuffle.join
  end
end

p "test".shuffle
#=> "tste"
```

3. Verify that Listing 4.16 works even if you remove **`self.`**.

```ruby
class String
  def shuffle
    split('').shuffle.join
  end
end

p "test".shuffle
#=> "tste"
```

## 4.4.4 \***\*A Controller Class\*\***

1. By running the Rails console in the toy app’s directory from Chapter 2, confirm that you can create a **`user`** object using **`User.new`**.

```ruby
>> user = User.new
   (0.9ms)  SELECT sqlite_version(*)
=> #<User id: nil, name: nil, email: nil, created_at: nil, updat...
```

2. Determine the class hierarchy of the **`user`** object.

```ruby
>> user = User.new
   (0.9ms)  SELECT sqlite_version(*)
=> #<User id: nil, name: nil, email: nil, created_at: nil, updat...
>> user.class
=> User(id: integer, name: string, email: string, created_at: datetime, updated_at: datetime)
>> user.class.superclass
=> ApplicationRecord(abstract)
>> user.class.superclass.superclass
=> ActiveRecord::Base
>> user.class.superclass.superclass.superclass
=> Object
>> user.class.superclass.superclass.superclass.superclass
=> BasicObject
>> user.class.superclass.superclass.superclass.superclass.superclass4
```

## 4.4.5 \***\*A User Class\*\***

1. In the example User class, change from **`name`** to separate first and last name attributes, and then add a method called **`full_name`** that returns the first and last names separated by a space. Use it to replace the use of **`name`** in the formatted email method.

```ruby
class User
  attr_accessor :first_name, :last_name, :email

  def initialize(attributes = {})
    @first_name = attributes[:first_name]
    @last_name = attributes[:last_name]
    @email = attributes[:email]
  end

  def formatted_email
    "#{@name} <#{@email}>"
  end

  def full_name
    "#{@first_name} #{@last_name}"
  end
end

user = User.new(first_name: 'Jack', last_name: 'Jackson', email: 'jack@mail.com')

p user.full_name
#=> "Jack Jackson"
```

2. Add a method called **`alphabetical_name`** that returns the last name and first name separated by comma-space.

```ruby
# ...
def alphabetical_name
  "#{@last_name}, #{@first_name}"
end
# ...

user = User.new(first_name: 'Jack', last_name: 'Jackson', email: 'jack@mail.com')

p user.alphabetical_name
#=> "Jackson, Jack"
```

3. Verify that **`full_name.split`** is the same as **`alphabetical_name.split(', ').reverse`**.

```ruby
p user1 = user.full_name.split                         #=> ["Jack", "Jackson"]
p user2 = user.alphabetical_name.split(', ').reverse   #=> ["Jack", "Jackson"]
p user1 == user2                                       #=> true
```
