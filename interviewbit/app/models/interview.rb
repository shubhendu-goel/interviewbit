class Interview < ApplicationRecord
	validates :title, presence: true, length: { minimum: 3 }
	validates :start, presence: true
	validates :finish, presence: true
	has_and_belongs_to_many :users ,-> { distinct }
	validate :finish_after_start
	validate :start_after_current
	private
		def finish_after_start
			if start>finish
				errors.add(:finish, "must be after the start datetime")
			end
		end
		def start_after_current
			if start<Time.now
				errors.add(:start, "must be after the current datetime")
			end
		end
	end
end
