# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


user_data = [{login_identifier: 'a@a.in', email: 'a@a.in', name: 'AAA'},
          {login_identifier: 'b@a.in', email: 'b@a.in', name: 'BBB'},
          {login_identifier: 'c@a.in', email: 'c@a.in', name: 'CCC'}
          ]
user_data.each do |user|
  User.create(user.merge(status: 'active', password: '123456', password_confirmation: '123456'))
end
users = User.all
10.times do
  schedule = Schedule.new(priority: rand(10), status: 'active', queue: 'default', cron_schedule: '2 2 * * *')
  ecode = "code" + rand(1000).to_s
  event = schedule.events.build(code: ecode, name: "Event #{ecode}", status: 'active')
  u = users[rand(users.count)]
  schedule.user_id = u.id
  schedule.last_updated_by_id = u.id
  schedule.save
end