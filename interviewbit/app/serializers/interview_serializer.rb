class InterviewSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :start, :finish, :id
  has_many :users
end
