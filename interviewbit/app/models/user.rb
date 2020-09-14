class User < ApplicationRecord
	validates :name, presence: true, length: { minimum: 3 }

	has_one_attached :resume
	has_and_belongs_to_many :interviews
end
