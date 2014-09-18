puts 'SEDDING...'

ActiveRecord::Base.transaction do
	# Create Admin
	User.create!(
			username: "Nam Nguyen",
			email: "nguyentatnam53ac@gmail.com",
			password: "12345678",
			password_confirmation: "12345678",
			role: "admin"
		) 
	# Create User
	["Nam", "Viet", "Yen", "Ha",
		 "Minh", "Mai", "Van"].each do |user_name|
		User.create!(
			username: "#{user_name}",
			email: "#{user_name}@gmail.com",
			password: "12345678",
			password_confirmation: "12345678",
			role: "author"
		) 	
	end
	puts "#{User.count} users"

	# Create Post
	User.all.each do |user|
		rand(10..20).times do |i|
			Post.create!(
				user_id: user.id,
				title: Faker::Lorem.sentence,
				description: Faker::Lorem.sentence,
				content: Faker::Lorem.paragraph,
			)	
		end
	end
	puts "#{Post.count} posts"
end
