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
			if Time.now.to_i > start.to_i	
				errors.add(:start, "must be after the current datetime")
			end
		end
		def finish_after_start
			if start.to_i > finish.to_i
				errors.add(:finish, "must be after the start datetime")
			end
		end
		def available_users
			users.each do |u|
				uid=u.id
				inter = Interview.joins(:users).where("interviews_users.user_id = ?", uid )
				inter.each do |i|
					st=i.start.to_i
					fs=i.finish.to_i
					if ((st>=start.to_i && st<=finish.to_i) || (fs>=start.to_i && fs<=finish.to_i) || (st<=start.to_i && fs>=finish.to_i)) 
						errors.add(:user, String(u.name)+ " Unavailable")	
					end
				end
			end			
		end
end
