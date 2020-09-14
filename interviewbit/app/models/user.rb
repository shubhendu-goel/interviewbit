class User < ApplicationRecord
	has_one_attached :resume
	has_many :interviews
end
