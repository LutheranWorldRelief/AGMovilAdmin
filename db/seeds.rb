if User.all.size == 0
	user = User.create(names: "Super", lastnames: "Administrador", email: "admin@cacaomovil.com", password: "123123123", password_confirmation: "123123123")
	if user.has_role? :admin
		user.remove_role :admin
		user.add_role :super_ad
	end
	puts "email => #{user.email}"
	puts "password => 123123123"
end

