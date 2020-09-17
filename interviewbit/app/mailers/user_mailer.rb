class UserMailer < ApplicationMailer
	default from: 'goelshubhendu@gmail.com'
	
 	def welcome_email(id)
		@u = User.find(id)
		@url  = 'http://localhost:3001'
		mail(to: @u.email, subject: 'Welcome to Interview Creation Portal')
	end
	def reminder_email(id)
			@i=Interview.find(id)
			users= Array.new
			@i.users.each do |usr|
				users.append(usr.email)
			end
			mail(to: 'smartyshubhendu@gmail.com', cc: users, subject: 'Reminder Email')
		
	end
	def new_interview_email(id)
		@i = Interview.find(id)
		users= Array.new
		@i.users.each do |usr|
			users.append(usr.email)
		end
		mail(to: 'smartyshubhendu@gmail.com', cc: users, subject: 'New Interview Scheduled')
	end
	def update_interview_email(id)
		@i = Interview.find(id)
		users= Array.new
		@i.users.each do |usr|
			users.append(usr.email)
		end
		mail(to: 'smartyshubhendu@gmail.com', cc: users, subject: 'Interview Updated ')
	end
	def destroy_interview_email
		@i=Interview.new
		@i.title = params[:arg][0]
		@i.start = params[:arg][1]
		@i.finish = params[:arg][2]
		n=params[:arg].length()
		users=Array.new
		j=3
		begin
			users.append(params[:arg][j])
			j=j+1
		end until j >= n
		mail(to: 'smartyshubhendu@gmail.com', cc: users, subject: 'Interview Cancelled')
	end
end
