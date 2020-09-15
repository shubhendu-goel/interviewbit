class UserMailer < ApplicationMailer
	default from: 'goelshubhendu@gmail.com'
 
	def welcome_email
		@user = params[:user]
		@url  = 'http://localhost:3001'
		mail(to: @user.email, subject: 'Welcome to Interview Creation Portal')
	end
end
