# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create!([{name: "Brad Jones", email: "123@o.com", password: "blablabla"},
  {name: "Bryce Jones", email: "123@p.com", password: "blablabla"},
  {name: "Alexander Jones", email: "456@f.com", password: "blablabla"},
  {name: "Giuseppe Jones", email: "789@g.com", password: "blablabla"}])

articles = Article.create!([{link: "tomatoes.com", message: "I<3 lycopene", user_id:1},
{link: "hello.com", message: "hi there", user_id:2},
{link: "headache.com", message: "I need a tylenol", user_id:3}, {link: "sillystuff.com",
  message: "This site is goofy.", user_id:2}, {link: "lalaland.com",
    message: "Actually Moonlight.com.", user_id:1}, {link: "corvid.com",
      message: "Caw caw!", user_id:1}])

comments = Comment.create!([{title: "Cool", content: "That's super neat.", article_id: 1, user_id: 2},
{title: "Hi", content: "Fascinating.", article_id: 1, user_id: 3},
{title: "Great article!", content: "Two thumbs way up.", article_id: 3, user_id: 2},
{title: "Yahoo", content: "Great.", article_id: 2, user_id: 1},
{title: "Holla", content: "Good point.", article_id: 1, user_id: 2}])

friendships = Friendship.create!([{user_id: 1, friend_id: 2},
{user_id: 1, friend_id: 3},
{user_id: 2, friend_id: 4},
{user_id: 2, friend_id: 1},
{user_id: 3, friend_id: 2},
{user_id: 3, friend_id: 4}])
