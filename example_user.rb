class User
	attr_accessor :username, :email

	def initialize(attributes={})
		@name = attributes[:username]
		@email = attributes[:email]
	end

	def formatted_email
		"#{@username} <#{@email}>"
	end
end