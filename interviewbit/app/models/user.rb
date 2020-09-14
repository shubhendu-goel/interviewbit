class User < ApplicationRecord
	has_one_attached :resume
	has_and_belongs_to_many :interviews
end
