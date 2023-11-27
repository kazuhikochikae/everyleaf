# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  email: 'new@test03.com',
  name: '新しいユーザー3',
  password: '123456',
)
User.create!(
  email: 'new@test04.com',
  name: '新しいユーザー4',
  password: '123456',
)
User.create!(
  email: 'new@test05.com',
  name: '新しいユーザー5',
  password: '123456',
)
User.create!(
  email: 'new@test06.com',
  name: '新しいユーザー6',
  password: '123456',
)
User.create!(
  email: 'new@test07.com',
  name: '新しいユーザー7',
  password: '123456',
)
User.create!(
  email: 'new@test08.com',
  name: '新しいユーザー8',
  password: '123456',
)
User.create!(
  email: 'new@test09.com',
  name: '新しいユーザー9',
  password: '123456',
)
User.create!(
  email: 'new@test10.com',
  name: '新しいユーザー10',
  password: '123456',
)
User.create!(
  email: 'new@test11.com',
  name: '新しいユーザー11',
  password: '123456',
)
User.create!(
  email: 'new@test12.com',
  name: '新しいユーザー11',
  password: '123456',
)

Label.create(title: "Label4")
Label.create(title: "Label5")
Label.create(title: "Label6")
Label.create(title: "Label7")
Label.create(title: "Label8")
Label.create(title: "Label9")
Label.create(title: "Labe20")
Label.create(title: "Labe21")
Label.create(title: "Labe22")
Label.create(title: "Labe23")

Task.create(
  user_id: 1,
  name: 'test',
  detail: '詳細',
  deadline: '2023-11-17',
  status: '未着手',
  rank: 'high'
)
Task.create(
  user_id: 2,
  name: 'test',
  detail: '詳細',
  deadline: '2023-11-17',
  status: '未着手',
  rank: 'high'
)
Task.create(
  user_id: 3,
  name: 'test',
  detail: '詳細',
  deadline: '2023-11-17',
  status: '未着手',
  rank: 'high'
)
Task.create(
  user_id: 4,
  name: 'test',
  detail: '詳細',
  deadline: '2023-11-17',
  status: '未着手',
  rank: 'high'
)
Task.create(
  user_id: 5,
  name: 'test',
  detail: '詳細',
  deadline: '2023-11-17',
  status: '未着手',
  rank: 'high'
)
Task.create(
  user_id: 6,
  name: 'test',
  detail: '詳細',
  deadline: '2023-11-17',
  status: '未着手',
  rank: 'high'
)
Task.create(
  user_id: 7,
  name: 'test',
  detail: '詳細',
  deadline: '2023-11-17',
  status: '未着手',
  rank: 'high'
)
Task.create(
  user_id: 8,
  name: 'test',
  detail: '詳細',
  deadline: '2023-11-17',
  status: '未着手',
  rank: 'high'
)
Task.create(
  user_id: 9,
  name: 'test',
  detail: '詳細',
  deadline: '2023-11-17',
  status: '未着手',
  rank: 'high'
)
Task.create(
  user_id: 10,
  name: 'test',
  detail: '詳細',
  deadline: '2023-11-17',
  status: '未着手',
  rank: 'high'
)

