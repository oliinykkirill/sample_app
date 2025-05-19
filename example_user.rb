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

  def alphabetical_name
    "#{@last_name}, #{@first_name}"
  end
end

user = User.new(first_name: 'Jack', last_name: 'Jackson', email: 'jack@mail.com')

p user.alphabetical_name
#=> "Jack Jackson"

p user1 = user.full_name.split
p user2 = user.alphabetical_name.split(', ').reverse

p user1 == user2

