class InterviewSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :start, :end
  has_many :users
end
