class InterviewSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :start, :finish
  has_and_belongs_to_many :users
end
