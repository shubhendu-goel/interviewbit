class InterviewSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :start, :finish
  has_many :users
end
