class UserMailer < ApplicationMailer
	default from: 'goelshubhendu@gmail.com'
 
	def welcome_email
		@u = params[:u]
		@url  = 'http://localhost:3001'
		mail(to: @u.email, subject: 'Welcome to Interview Creation Portal')
	end
	def new_interview_email
		@i = Interview.find(params[:arg][0])
		n=params[:arg].length()
		users=Array.new
		j=1
		begin
			u=User.find(params[:arg][j])
			users.append(u.email)
			j=j+1
		end until j >= n
		mail(to: 'smartyshubhendu@gmail.com', cc: users, subject: 'Welcome to Interview Creation Portal')
	end
	def update_interview_email
		@i = params[:interview]

	end
	def destroy_interview_email
		@i = params[:interview]

	end
end
