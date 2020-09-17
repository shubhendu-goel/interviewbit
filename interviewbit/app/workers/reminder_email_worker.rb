class ReminderEmailWorker 
	include Sidekiq::Worker
	include Sidetiq::Scheduable
	sidekiq_options :queue => :mailer 
	recurrence { daily }
	def perform
		UserMailer.reminder_email
	end
end