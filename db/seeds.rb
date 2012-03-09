# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
Article.delete_all
Article::Tag.delete_all

regular_guy = User.create(email: "0xf013@gmail.com", password: 123123)
british_bastard = User.create(email: "union_jack_45435@gmail.com", password: 123123)

tags = Article::Tag.create([
  {title: "Release"},
  {title: "Strategy"},
  {title: "VOD"}
])

articles = Article.create([
  {
    title: "Starcraft 2 released!",
    body: "Oh my god, I cannot believe it! Bla bla bla! Bla again!",
    user:regular_guy,
    tags: [tags[1], tags[2]]
  },

  {title: "Naniwa kicking some ass",
   body: "Naniwa strikes again! Several asses kicked!", user: regular_guy, tags: [tags[1], tags[2], tags[0]]},

  {title: "Bloody koreans",
   body: "Europe perpetually bereft of pro players. Korea is dominating", user: british_bastard, tags: [tags[1]]},

  {title: "Kareon super secret strategy",
   body: "Today Kareon will present his new secret strategy: The 4 Gate Push", user: british_bastard, tags: [tags[1]]}

])


comments_list = [
    {title: "OMG THAT ROCKS!", comment: "YEAH BABY! YEAH!", user: regular_guy},
    {title: "Indeed, my dear friend", comment: "I beg your pardon, pumpkin", user: british_bastard}]



comments_list.each do |c|
 articles.first.comments.create c
end