require 'faker'

# Create Users
20.times do
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Lorem.characters(10)
    )
  user.skip_confirmation!
  user.save!
end
users = User.all

# Create Wikis

100.times do
  Wiki.create!(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph
    )
end
wikis = Wiki.all

# Create an admin user
  admin = User.new(
    name: 'Alice Admin',
    email: 'firstadmin@example.com',
    password: 'helloworld',
    role: 'admin'
    )

  admin.skip_confirmation!
  admin.save!

  # Create a premium user
    premium = User.new(
      name: 'Mike Premium',
      email: 'firstpremium@example.com',
      password: 'helloworld',
      role: 'premium'
      )

    premium.skip_confirmation!
    premium.save!

    # Create a standard user

      standard = User.new(
        name: 'Super Standard',
        email: 'firststandard@example.com',
        password: 'helloworld',
        role: 'standard'
        )

      standard.skip_confirmation!
      standard.save!
puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
puts "#{admin.name}"
puts "#{premium.name}"
puts "#{standard.name}"