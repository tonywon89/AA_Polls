# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
5.times do
  u = User.create!(name: Faker::Name.name)
  poll = Poll.create!(title: Faker::Book.title, author_id: u.id)
  2.times do
    q = Question.create!(text: Faker::Lorem.sentence + "?", poll_id: poll.id )
    2.times do
      a = AnswerChoice.create!(text: Faker::Lorem.sentence, question_id: q.id)

      Response.create!(user_id: u.id, answer_choice_id: a.id)

    end

  end
end
