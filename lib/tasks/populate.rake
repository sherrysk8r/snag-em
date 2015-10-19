namespace :db do
  desc "Erase and fill database"
  # creating a rake task within db namespace called 'populate'
  # executing 'rake db:populate' will cause this script to run
  task :populate => :environment do
    # Drop the old db and recreate from scratch
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    # Invoke rake db:migrate
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:test:prepare'].invoke
    # Need gem to make this work when adding students later: faker
    # Docs at: http://faker.rubyforge.org/rdoc/
    require 'faker'
    require 'factory_girl_rails'

    cmu = Group.new
    cmu.name = "Carnegie Mellon University"
    cmu.open_group = TRUE
    cmu.save!
    # Step 1: Create users
    
    sherry = User.new
    sherry.first_name = "Sherry"
    sherry.last_name = "Chen"
    sherry.about_me = "I go to CMU."
    sherry.email = "sherry@example.com"
    sherry.phone = "412-268-2323"
    sherry.active = true
    sherry.password = "secret"
    sherry.password_confirmation = "secret"
    sherry.save!

    cmuSherry = GroupMember.new
    cmuSherry.groupId = cmu.id
    cmuSherry.userId = sherry.id
    cmuSherry.save!

    ian = User.new
    ian.first_name = "Ian"
    ian.last_name = "Go"
    ian.about_me = "I go to CMU."
    ian.email = "ian@example.com"
    ian.phone = "412-268-2323"
    ian.active = true
    ian.password = "secret"
    ian.password_confirmation = "secret"
    ian.save!

    cmuIan = GroupMember.new
    cmuIan.groupId = cmu.id
    cmuIan.userId = ian.id
    cmuIan.save!

    hannah = User.new
    hannah.first_name = "Hannah"
    hannah.last_name = "Douglas"
    hannah.about_me = "I go to CMU."
    hannah.email = "hannah@example.com"
    hannah.phone = "412-268-2323"
    hannah.active = true
    hannah.password = "secret"
    hannah.password_confirmation = "secret"
    hannah.save!

    cmuHannah = GroupMember.new
    cmuHannah.groupId = cmu.id
    cmuHannah.userId = hannah.id
    cmuHannah.save!

    laura = User.new
    laura.first_name = "Laura"
    laura.last_name = "Lodewyk"
    laura.about_me = "I go to CMU."
    laura.email = "laura@example.com"
    laura.phone = "412-268-2323"
    laura.active = true
    laura.password = "secret"
    laura.password_confirmation = "secret"
    laura.save!
    
    cmuLaura = GroupMember.new
    cmuLaura.groupId = cmu.id
    cmuLaura.userId = laura.id
    cmuLaura.save!

    run1 = Post.new
    run1.owner_id = ian.id
    run1.title = "Run Around Schenley"
    run1.topic = "Running"
    run1.start = DateTime.new(2015, 10, 22, 15, 0, 0)
    run1.expected_duration_hr = 1
    run1.expected_duration_min = 30
    run1.details = "Meet behind Hunt. I will be wearing a IS sweater."
    run1.cancelled = FALSE
    run1.estimated_difficulty = 3
    run1.save!

    run2 = Post.new
    run2.owner_id = sherry.id
    run2.title = "Run Around Schenley"
    run2.topic = "Running"
    run2.start = DateTime.new(2015, 10, 22, 10, 0, 0)
    run2.expected_duration_hr = 0
    run2.expected_duration_min = 45
    run2.details = "Meet behind Hunt. I will be wearing a IS sweater."
    run2.cancelled = FALSE
    run2.estimated_difficulty = 2
    run2.save!

    run3 = Post.new
    run3.owner_id = hannah.id
    run3.title = "Run Through Squirrel Hill"
    run3.topic = "Running"
    run3.start = DateTime.new(2015, 10, 22, 16, 0, 0)
    run3.expected_duration_hr = 0
    run3.expected_duration_min = 30
    run3.details = "Meet at Margaret Morrison bus stop. I will be wearing a IS sweater."
    run3.cancelled = FALSE
    run3.estimated_difficulty = 4
    run3.save!

    run4 = Post.new
    run4.owner_id = laura.id
    run4.title = "Run Through Squirrel Hill"
    run4.topic = "Running"
    run4.start = DateTime.new(2015, 10, 23, 9, 0, 0)
    run4.expected_duration_hr = 1
    run4.expected_duration_min = 0
    run4.details = "Meet at Margaret Morrison bus stop. I will be wearing a IS sweater."
    run4.cancelled = FALSE
    run4.estimated_difficulty = 2
    run4.save!

    run5 = Post.new
    run5.owner_id = ian.id
    run5.title = "Run to Craig and Back"
    run5.topic = "Running"
    run5.start = DateTime.new(2015, 10, 22, 13, 30, 0)
    run5.expected_duration_hr = 1
    run5.expected_duration_min = 15
    run5.details = "Meet by Walk to Sky. I will be wearing a IS sweater."
    run5.cancelled = FALSE
    run5.estimated_difficulty = 1
    run5.save!

    run6 = Post.new
    run6.owner_id = laura.id
    run6.title = "Run to Craig and Back"
    run6.topic = "Running"
    run6.start = DateTime.new(2015, 10, 22, 20, 30, 0)
    run6.expected_duration_hr = 0
    run6.expected_duration_min = 45
    run6.details = "Meet by Walk to Sky. I will be wearing a IS sweater."
    run6.cancelled = FALSE
    run6.estimated_difficulty = 5
    run6.save!
    
    cities = [Faker::Address.city, Faker::Address.city, Faker::Address.city, Faker::Address.city, Faker::Address.city, Faker::Address.city, Faker::Address.city, Faker::Address.city, Faker::Address.city]
    
    states = [Faker::Address.state,Faker::Address.state,Faker::Address.state,Faker::Address.state]

    100.times do
      user = User.new
      user.last_name = Faker::Name.last_name
      user.first_name = Faker::Name.first_name 
      user.email = Faker::Internet.safe_email(user.first_name + '-' + user.last_name)
      user.phone = Faker::Base.numerify('(###)-###-####')
      user.city = cities.sample
      user.state = states.sample
      user.about_me = "I LOVE THIS APP!"
      user.date_of_birth = Faker::Date.between(30.years.ago, 15.years.ago)
      user.password = "secret"
      user.password_confirmation = "secret"
      user.active = TRUE
      user.save!
      
    end

    all_users = User.all
    topics = ["Running", "Lifting", "Swimming", "Ballroom", "Yoga", "Stretching"]
    #create some posts
    150.times do
        post = Post.new
        post.owner_id = all_users.sample.id
        post.title = Faker::Lorem.sentence(3, true, 1)
        post.topic = topics.sample
        time = Faker::Time.between(1.day.from_now, 5.weeks.from_now, :morning)
        post.start = time
        post.expected_duration_hr = rand(0..2)
        post.expected_duration_min = rand(1..59)
        post.cancelled = FALSE
        post.estimated_difficulty = rand(1..10)
        post.save!
    end
  end
end