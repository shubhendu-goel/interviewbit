class Interview < ApplicationRecord
	validates :title, presence: true, length: { minimum: 3 }
	validates :start, presence: true
	validates :finish, presence: true
	has_and_belongs_to_many :users , -> { distinct }
	validate :atleast_2_users , on: :create
	validate :finish_after_start
	validate :start_after_now
	validate :available_users , on: :create
	private
		def atleast_2_users
			if users.size < 2
				errors.add(:minimum , "2 users are required")
			end 
		end
		def start_after_now
			if Time.now > (start.strftime("%Y-%m-%d %H:%M:%S") + " UTC")	
				errors.add(:start, "must be after the current datetime")
			end
		end
		def finish_after_start
			if (start.strftime("%Y-%m-%d %H:%M:%S") + " UTC") > (finish.strftime("%Y-%m-%d %H:%M:%S") + " UTC")
				errors.add(:finish, "must be after the start datetime")
			end
		end
		def available_users
			str=start.strftime("%Y-%m-%d %H:%M:%S") + " UTC"
			fns=finish.strftime("%Y-%m-%d %H:%M:%S") + " UTC"
			users.each do |u|
				uid=u.id
				inter = Interview.joins(:users).where("interviews_users.user_id = ?", uid )
				inter.each do |i|
					st=i.start
					fs=i.finish
					if ((st>=str && st<=fns) || (fs>=str && fs<=fns) || (st<=str && fs>=fns)) 
						errors.add(:user, String(u.name)+ " Unavailable")	
					end
				end
			end
		end
end
