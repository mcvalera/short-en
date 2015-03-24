require 'faker'

10.times do
  Url.create(full_url: Faker::Internet.url, shortened_url: "goo.gl")
end